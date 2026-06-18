import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FcmService {
  FcmService({
    FirebaseMessaging? messaging,
    DeviceInfoPlugin? deviceInfo,
    FlutterLocalNotificationsPlugin? localNotifications,
  }) : _messaging = messaging ?? FirebaseMessaging.instance,
       _deviceInfo = deviceInfo ?? DeviceInfoPlugin(),
       _localNotifications =
           localNotifications ?? FlutterLocalNotificationsPlugin();

  final FirebaseMessaging _messaging;
  final DeviceInfoPlugin _deviceInfo;
  final FlutterLocalNotificationsPlugin _localNotifications;

  Future<void> ensureAndroidNotificationChannel() async {
    if (!Platform.isAndroid) return;

    const channel = AndroidNotificationChannel(
      'default_notification_channel',
      'Thông báo',
      description: 'Kênh thông báo mặc định của ứng dụng',
      importance: Importance.high,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
    debugPrint('[FCM][Service] Android notification channel ensured');
  }

  Future<String?> getTokenWithPermission() async {
    await _logEnvironment();
    debugPrint('[FCM][Service] request notification permission start');
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    debugPrint(
      '[FcmService] notification permission=${settings.authorizationStatus}',
    );
    debugPrint(
      '[FCM][Service] permission detail alert=${settings.alert}, badge=${settings.badge}, sound=${settings.sound}, '
      'announcement=${settings.announcement}, carPlay=${settings.carPlay}, criticalAlert=${settings.criticalAlert}, '
      'lockScreen=${settings.lockScreen}, notificationCenter=${settings.notificationCenter}',
    );

    final isAllowed =
        settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;
    if (!isAllowed) {
      debugPrint('[FCM][Service] permission denied, skip get token');
      return null;
    }

    if (Platform.isIOS) {
      final apnsToken = await _waitForApnsToken();
      if (apnsToken == null || apnsToken.isEmpty) {
        debugPrint('[FCM][Service] APNS token not ready, skip FCM token now');
        return null;
      }
    }

    try {
      final token = await _messaging.getToken();
      debugPrint('[FCM][Service] fcm token=${_shortToken(token)}');
      return token;
    } catch (error) {
      debugPrint('[FCM][Service] get FCM token error=$error');
      return null;
    }
  }

  Stream<String> get onTokenRefresh => _messaging.onTokenRefresh;

  Future<String> getDeviceInfo() async {
    debugPrint('[FCM][Service] getDeviceInfo start');
    try {
      if (Platform.isIOS) {
        final info = await _deviceInfo.iosInfo;
        final deviceInfo = '${info.name} ${info.utsname.machine}'.trim();
        debugPrint('[FCM][Service] iOS deviceInfo=$deviceInfo');
        return deviceInfo;
      }

      if (Platform.isAndroid) {
        final info = await _deviceInfo.androidInfo;
        final deviceInfo = '${info.manufacturer} ${info.model}'.trim();
        debugPrint('[FCM][Service] Android deviceInfo=$deviceInfo');
        return deviceInfo;
      }
    } catch (error) {
      debugPrint('[FCM][Service] getDeviceInfo error=$error');
    }

    debugPrint(
      '[FCM][Service] fallback deviceInfo=${Platform.operatingSystem}',
    );
    return Platform.operatingSystem;
  }

  String _shortToken(String? token) {
    if (token == null || token.isEmpty) return 'null';
    if (token.length <= 16) return token;
    return '${token.substring(0, 8)}...${token.substring(token.length - 8)}';
  }

  Future<String?> _waitForApnsToken() async {
    for (var attempt = 1; attempt <= 30; attempt++) {
      try {
        final apnsToken = await _messaging.getAPNSToken();
        debugPrint(
          '[FCM][Service] APNS attempt=$attempt token=${_shortToken(apnsToken)}',
        );
        if (apnsToken != null && apnsToken.isNotEmpty) {
          return apnsToken;
        }
      } catch (error) {
        debugPrint('[FCM][Service] APNS attempt=$attempt error=$error');
      }

      await Future.delayed(const Duration(seconds: 1));
    }

    return null;
  }

  Future<void> _logEnvironment() async {
    debugPrint('[FCM][Service] platform=${Platform.operatingSystem}');
    debugPrint('[FCM][Service] autoInit=${_messaging.isAutoInitEnabled}');
    try {
      final app = Firebase.app();
      debugPrint(
        '[FCM][Service] firebase app=${app.name}, projectId=${app.options.projectId}, '
        'appId=${app.options.appId}, iosBundleId=${app.options.iosBundleId}, messagingSenderId=${app.options.messagingSenderId}',
      );
    } catch (error) {
      debugPrint('[FCM][Service] Firebase.app error=$error');
    }

    try {
      if (Platform.isIOS) {
        final info = await _deviceInfo.iosInfo;
        debugPrint(
          '[FCM][Service] iOS physical=${info.isPhysicalDevice}, name=${info.name}, model=${info.model}, '
          'system=${info.systemName} ${info.systemVersion}, machine=${info.utsname.machine}',
        );
      } else if (Platform.isAndroid) {
        final info = await _deviceInfo.androidInfo;
        debugPrint(
          '[FCM][Service] Android physical=${info.isPhysicalDevice}, manufacturer=${info.manufacturer}, model=${info.model}, sdk=${info.version.sdkInt}',
        );
      }
    } catch (error) {
      debugPrint('[FCM][Service] environment device info error=$error');
    }
  }
}
