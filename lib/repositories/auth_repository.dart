import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:htql_app/data/api/auth_api.dart';
import 'package:htql_app/data/api/dio_client.dart';
import 'package:htql_app/data/models/auth/login_response.dart';
import 'package:htql_app/repositories/fcm_repository.dart';
import 'package:htql_app/services/avatar_storage_service.dart';
import 'package:htql_app/services/storage_service.dart';

class AuthRepository {
  AuthRepository({
    AuthApi? authApi,
    StorageService? storageService,
    AvatarStorageService? avatarStorageService,
    FcmRepository? fcmRepository,
  }) : _authApi = authApi ?? AuthApi(DioClient.create()),
       _storageService = storageService ?? StorageService.instance,
       _avatarStorageService =
           avatarStorageService ?? AvatarStorageService.instance,
       _fcmRepository = fcmRepository ?? FcmRepository();

  final AuthApi _authApi;
  final StorageService _storageService;
  final AvatarStorageService _avatarStorageService;
  final FcmRepository _fcmRepository;

  String get accessToken => _storageService.getAuthAccessToken();

  bool get isLoggedIn => accessToken.isNotEmpty;

  LoginUser? get cachedUser {
    final rawUser = _storageService.getAuthUser();
    if (rawUser.isEmpty) return null;

    final json = jsonDecode(rawUser);
    if (json is! Map<String, dynamic>) return null;

    return LoginUser.fromJson(json);
  }

  Future<LoginResponse> login({
    required String username,
    required String password,
  }) async {
    try {
      debugPrint('[FCM][Auth] login start, username=$username');
      final response = await _authApi.login(
        username: username,
        password: password,
      );

      if (!response.status) {
        throw AuthException(response.message ?? 'Đăng nhập thất bại');
      }

      final token = response.accessToken ?? response.data?.accessToken;
      if (token == null || token.isEmpty) {
        throw const AuthException('Không nhận được token đăng nhập');
      }

      await _storageService.saveAuthAccessToken(token);

      final user = response.data;
      if (user != null) {
        await _storageService.saveAuthUser(jsonEncode(user.toJson()));
        try {
          await _avatarStorageService.cacheAvatar(user.employee?.avatar);
        } catch (_) {
          await _avatarStorageService.clearAvatar();
        }
      }

      try {
        debugPrint('[FCM][Auth] login success, sync FCM token start');
        await _fcmRepository.saveCurrentDeviceToken();
        debugPrint('[FCM][Auth] login success, sync FCM token completed');
      } catch (error) {
        debugPrint('[FCM][Auth] login success, sync FCM token failed=$error');
      }

      return response;
    } on DioException catch (error) {
      throw AuthException(_getDioErrorMessage(error));
    }
  }

  Future<void> logout() async {
    debugPrint('[FCM][Auth] logout start, delete FCM token before clear auth');
    await _fcmRepository.deleteCurrentDeviceToken();
    debugPrint('[FCM][Auth] logout delete FCM token completed');
    await _avatarStorageService.clearAvatar();
    await _storageService.clearAuth();
  }

  String _getDioErrorMessage(DioException error) {
    final data = error.response?.data;
    if (data is Map<String, dynamic>) {
      final message = data['message'];
      if (message is String && message.isNotEmpty) return message;
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Kết nối quá thời gian, vui lòng thử lại';
      case DioExceptionType.badResponse:
        return 'Tài khoản hoặc mật khẩu không đúng';
      case DioExceptionType.connectionError:
        return 'Không thể kết nối máy chủ';
      default:
        return 'Đăng nhập thất bại, vui lòng thử lại';
    }
  }
}

class AuthException implements Exception {
  const AuthException(this.message);

  final String message;

  @override
  String toString() => message;
}
