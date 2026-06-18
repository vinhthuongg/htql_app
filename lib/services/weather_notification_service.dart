import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:htql_app/services/storage_service.dart';
import 'package:htql_app/services/weather_forecast_service.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

class WeatherNotificationService {
  WeatherNotificationService._();

  static final WeatherNotificationService instance =
      WeatherNotificationService._();

  static const int _forecastReminderId = 1900;
  static const String _lastNotifiedDateKey = 'weather_last_notified_date';
  static final Random _random = Random();
  static const List<String> _rainMessages = [
    '☔ Ngày mai có khả năng xuất hiện mưa đó, nhớ mang theo ô hoặc áo mưa nhé!',
    '🌧️ Dự báo cho thấy thời tiết ngày mai có thể không được khô ráo lắm. Chuẩn bị sẵn ô hoặc áo mưa sẽ yên tâm hơn đó!',
    '🌦️ Có vẻ vài cơn mưa sẽ ghé qua vào ngày mai. Đừng quên mang theo ô hoặc áo mưa nha!',
    '☁️ Thời tiết ngày mai hơi "ẩm ương" một chút, chiếc ô nhỏ có thể sẽ rất hữu ích đó.',
    '🩵 Chưa chắc sẽ mưa, nhưng mang theo ô hoặc áo mưa sẽ giúp bạn chủ động hơn.',
    '🌙 Trước giờ đi ngủ, nhớ chuẩn bị sẵn ô hoặc áo mưa cho ngày mai nhé.',
    '🐻 Gấu nhỏ nhắc bạn: ngày mai có khả năng mưa, nhớ mang theo ô hoặc áo mưa nha!',
    '✨ Hy vọng trời sẽ đẹp, nhưng một chiếc ô luôn là người bạn đáng tin cậy đó.',
    '🌸 Dự báo ngày mai có thể có mưa, đừng để thời tiết làm bạn bất ngờ nhé!',
    '💙 Chúc bạn ngủ ngon, và nhớ mang theo ô hoặc áo mưa cho ngày mai nha.',
  ];
  static const List<String> _dryMessages = [
    '🌤️ Hiện chưa thấy dấu hiệu mưa vào ngày mai, nhưng mang theo ô hoặc áo mưa vẫn là một ý hay đó!',
    '☀️ Có vẻ ngày mai thời tiết khá đẹp. Chúc bạn một ngày thật vui và đừng quên chiếc ô nhỏ nhé!',
    '🌷 Dự báo hiện tại khá thuận lợi, nhưng chuẩn bị sẵn ô hoặc áo mưa sẽ giúp bạn an tâm hơn.',
    '🌈 Hy vọng ngày mai sẽ thật rực rỡ. Mang theo ô hoặc áo mưa để luôn sẵn sàng nha!',
    '😊 Chưa thấy dấu hiệu mưa, nhưng thời tiết đôi khi thích tạo bất ngờ đó. Đừng quên ô hoặc áo mưa nhé!',
    '🌞 Ngày mai có vẻ sẽ dễ chịu. Chúc bạn nhiều năng lượng và nhớ mang theo ô hoặc áo mưa nha!',
    '🌿 Trời có vẻ đẹp đó, nhưng một chiếc ô nhỏ sẽ luôn hữu ích.',
    '☕ Chúc bạn một ngày mai thật nhẹ nhàng. Đừng quên mang theo ô hoặc áo mưa nhé!',
    '💛 Mong rằng ngày mai sẽ thật suôn sẻ, và chiếc ô nhỏ sẽ đồng hành cùng bạn.',
    '✨ Dự báo khá khả quan cho ngày mai. Chuẩn bị sẵn ô hoặc áo mưa để luôn chủ động nhé!',
  ];

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;
  bool _timezoneInitialized = false;

  Future<void> init({bool force = false}) async {
    if (_initialized && !force) return;

    debugPrint(
      '[WeatherNotification] init start, platform=$defaultTargetPlatform, force=$force',
    );

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestSoundPermission: false,
      requestBadgePermission: false,
    );
    const settings = InitializationSettings(android: android, iOS: ios);

    final initialized = await _notifications.initialize(settings: settings);
    _initialized = initialized ?? true;
    debugPrint('[WeatherNotification] init done: $initialized');
  }

  Future<bool> requestPermission() async {
    await init();

    debugPrint('[WeatherNotification] requestPermission start');

    final androidPlugin = _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    final iosPlugin = _notifications
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();

    debugPrint(
      '[WeatherNotification] androidPlugin=${androidPlugin != null}, '
      'iosPlugin=${iosPlugin != null}',
    );

    final androidGranted = await androidPlugin
        ?.requestNotificationsPermission();
    final iosGranted = await iosPlugin?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    final iosPermissions = await iosPlugin?.checkPermissions();

    debugPrint(
      '[WeatherNotification] permission android=$androidGranted, ios=$iosGranted',
    );
    debugPrint(
      '[WeatherNotification] ios permissions enabled=${iosPermissions?.isEnabled}, '
      'alert=${iosPermissions?.isAlertEnabled}, sound=${iosPermissions?.isSoundEnabled}, '
      'badge=${iosPermissions?.isBadgeEnabled}, provisional=${iosPermissions?.isProvisionalEnabled}',
    );

    final granted = androidGranted ?? iosGranted ?? true;
    if (granted) {
      await init(force: true);
    }

    return granted;
  }

  Future<void> notifyForecast(MorningRainForecast forecast) async {
    await init();

    await _showNotification(
      title: forecast.title,
      body: _randomForecastMessage(forecast),
    );
  }

  Future<void> scheduleForecastAtNextSevenPm(
    MorningRainForecast forecast,
  ) async {
    await init();
    _ensureTimezoneInitialized();

    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      19,
    );
    if (!scheduledDate.isAfter(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    debugPrint(
      '[WeatherNotification] schedule forecast at $scheduledDate, title=${forecast.title}',
    );

    await _notifications.cancel(id: _forecastReminderId);
    await _scheduleNotification(
      id: _forecastReminderId,
      title: forecast.title,
      body: _randomForecastMessage(forecast),
      scheduledDate: scheduledDate,
    );
  }

  Future<void> cancelForecastReminder() async {
    await init();
    debugPrint('[WeatherNotification] cancel forecast reminder');
    await _notifications.cancel(id: _forecastReminderId);
  }

  DateTime nextSevenPm() {
    final now = DateTime.now();
    var scheduledDate = DateTime(now.year, now.month, now.day, 19);
    if (!scheduledDate.isAfter(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> _showNotification({
    required String title,
    required String body,
  }) async {
    debugPrint('[WeatherNotification] show start: title=$title, body=$body');

    const androidDetails = AndroidNotificationDetails(
      'weather_reminder',
      'Nhắc thời tiết',
      channelDescription: 'Thông báo dự báo mưa khung 06:00 - 07:00 sáng mai',
      icon: '@mipmap/ic_launcher',
      importance: Importance.max,
      priority: Priority.max,
    );
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      presentBanner: true,
      presentList: true,
    );

    await _notifications.show(
      id: _forecastReminderId,
      title: title,
      body: body,
      notificationDetails: const NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      ),
    );

    debugPrint('[WeatherNotification] show completed');
  }

  Future<void> _scheduleNotification({
    required int id,
    required String title,
    required String body,
    required tz.TZDateTime scheduledDate,
  }) async {
    debugPrint(
      '[WeatherNotification] zonedSchedule start: id=$id, title=$title, date=$scheduledDate',
    );

    await _notifications.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: scheduledDate,
      notificationDetails: _notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );

    debugPrint('[WeatherNotification] zonedSchedule completed');
    await _logPendingNotifications();
  }

  Future<void> _logPendingNotifications() async {
    final pending = await _notifications.pendingNotificationRequests();
    debugPrint('[WeatherNotification] pending count=${pending.length}');
    for (final item in pending) {
      debugPrint(
        '[WeatherNotification] pending id=${item.id}, title=${item.title}, body=${item.body}',
      );
    }
  }

  NotificationDetails _notificationDetails() {
    const androidDetails = AndroidNotificationDetails(
      'weather_reminder',
      'Nhắc thời tiết',
      channelDescription: 'Thông báo dự báo mưa khung 06:00 - 07:00 sáng mai',
      icon: '@mipmap/ic_launcher',
      importance: Importance.max,
      priority: Priority.max,
    );
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      presentBanner: true,
      presentList: true,
    );

    return const NotificationDetails(android: androidDetails, iOS: iosDetails);
  }

  String _randomForecastMessage(MorningRainForecast forecast) {
    final messages = forecast.willRain ? _rainMessages : _dryMessages;
    final message = messages[_random.nextInt(messages.length)];
    debugPrint('[WeatherNotification] random message: $message');
    return message;
  }

  void _ensureTimezoneInitialized() {
    if (_timezoneInitialized) return;
    tz_data.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Ho_Chi_Minh'));
    _timezoneInitialized = true;
    debugPrint('[WeatherNotification] timezone initialized: ${tz.local.name}');
  }

  Future<bool> notifyIfNeeded({
    required WeatherForecastService forecastService,
  }) async {
    debugPrint('[WeatherNotification] notifyIfNeeded start');
    final today = _dateKey(DateTime.now());
    final lastNotifiedDate = StorageService.instance.getString(
      _lastNotifiedDateKey,
    );
    debugPrint(
      '[WeatherNotification] today=$today, lastNotifiedDate=$lastNotifiedDate',
    );
    if (lastNotifiedDate == today) {
      debugPrint('[WeatherNotification] skipped: already notified today');
      return false;
    }

    final forecast = await forecastService.getTomorrowMorningForecast();
    debugPrint(
      '[WeatherNotification] forecast probability=${forecast.probability}, '
      'precipitation=${forecast.precipitation}, willRain=${forecast.willRain}',
    );
    await notifyForecast(forecast);
    await StorageService.instance.setString(_lastNotifiedDateKey, today);
    debugPrint('[WeatherNotification] notifyIfNeeded completed');
    return true;
  }

  String _dateKey(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }
}
