import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:htql_app/data/api/dio_client.dart';
import 'package:htql_app/data/api/fcm_api.dart';
import 'package:htql_app/services/fcm_service.dart';
import 'package:htql_app/services/storage_service.dart';

class FcmRepository {
  FcmRepository({
    FcmApi? fcmApi,
    FcmService? fcmService,
    StorageService? storageService,
  }) : _fcmApi = fcmApi ?? FcmApi(DioClient.create()),
       _fcmService = fcmService ?? FcmService(),
       _storageService = storageService ?? StorageService.instance;

  final FcmApi _fcmApi;
  final FcmService _fcmService;
  final StorageService _storageService;
  bool _isSavingToken = false;
  int _saveRetryCount = 0;

  void listenTokenRefresh() {
    debugPrint('[FCM][Repository] listen token refresh start');
    _fcmService.onTokenRefresh.listen((token) async {
      debugPrint(
        '[FCM][Repository] onTokenRefresh token=${_shortToken(token)}',
      );
      final accessToken = _storageService.getAuthAccessToken();
      if (accessToken.isEmpty || token.isEmpty) {
        debugPrint(
          '[FCM][Repository] skip refresh save: accessToken/token empty',
        );
        return;
      }

      try {
        final deviceInfo = await _fcmService.getDeviceInfo();
        debugPrint(
          '[FCM][Repository] refresh save API start deviceInfo=$deviceInfo',
        );
        await _fcmApi.saveToken(
          authorization: 'Bearer $accessToken',
          body: {'token': token, 'device_info': deviceInfo},
        );
        await _storageService.saveFcmToken(token);
        debugPrint('[FCM][Repository] refresh save API success');
      } catch (error) {
        debugPrint('[FCM][Repository] refresh save API failed=$error');
      }
    });
  }

  Future<void> saveCurrentDeviceToken() async {
    debugPrint('[FCM][Repository] saveCurrentDeviceToken start');
    if (_isSavingToken) {
      debugPrint('[FCM][Repository] skip save: another save is running');
      return;
    }

    final accessToken = _storageService.getAuthAccessToken();
    if (accessToken.isEmpty) {
      debugPrint('[FCM][Repository] skip save: auth token empty');
      return;
    }

    _isSavingToken = true;
    try {
      final fcmToken = await _fcmService.getTokenWithPermission();
      if (fcmToken == null || fcmToken.isEmpty) {
        if (_saveRetryCount < 5) {
          _saveRetryCount++;
          debugPrint(
            '[FCM][Repository] token empty, retry=$_saveRetryCount/5 after 5 seconds',
          );
          Future.delayed(const Duration(seconds: 5), saveCurrentDeviceToken);
        } else {
          debugPrint('[FCM][Repository] token empty, stop retry');
        }
        return;
      }
      _saveRetryCount = 0;

      final deviceInfo = await _fcmService.getDeviceInfo();
      debugPrint(
        '[FCM][Repository] save API start token=${_shortToken(fcmToken)}, deviceInfo=$deviceInfo',
      );
      await _fcmApi.saveToken(
        authorization: 'Bearer $accessToken',
        body: {'token': fcmToken, 'device_info': deviceInfo},
      );
      await _storageService.saveFcmToken(fcmToken);

      debugPrint('[FCM][Repository] save API success');
    } finally {
      _isSavingToken = false;
    }
  }

  Future<void> deleteCurrentDeviceToken() async {
    debugPrint('[FCM][Repository] deleteCurrentDeviceToken start');
    final accessToken = _storageService.getAuthAccessToken();
    final fcmToken = _storageService.getFcmToken();
    if (accessToken.isEmpty || fcmToken.isEmpty) {
      debugPrint(
        '[FCM][Repository] skip delete: accessToken empty=${accessToken.isEmpty}, fcmToken empty=${fcmToken.isEmpty}',
      );
      return;
    }

    try {
      debugPrint(
        '[FCM][Repository] delete API start token=${_shortToken(fcmToken)}',
      );
      await _fcmApi.deleteToken(
        authorization: 'Bearer $accessToken',
        body: {'token': fcmToken},
      );
      debugPrint('[FCM][Repository] delete API success');
    } on DioException catch (error) {
      debugPrint(
        '[FCM][Repository] delete API DioException status=${error.response?.statusCode}, data=${error.response?.data}, message=${error.message}',
      );
    } catch (error) {
      debugPrint('[FCM][Repository] delete API failed=$error');
    } finally {
      await _storageService.clearFcmToken();
      debugPrint('[FCM][Repository] local fcm token cleared');
    }
  }

  String _shortToken(String token) {
    if (token.length <= 16) return token;
    return '${token.substring(0, 8)}...${token.substring(token.length - 8)}';
  }
}
