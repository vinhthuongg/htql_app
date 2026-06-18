import 'package:flutter/foundation.dart';
import 'package:htql_app/services/storage_service.dart';
import 'package:htql_app/services/weather_forecast_service.dart';
import 'package:htql_app/services/weather_notification_service.dart';

class WeatherReminderProvider extends ChangeNotifier {
  WeatherReminderProvider({
    WeatherForecastService? forecastService,
    WeatherNotificationService? notificationService,
  }) : _forecastService = forecastService ?? WeatherForecastService(),
       _notificationService =
           notificationService ?? WeatherNotificationService.instance {
    _load();
  }

  static const String _enabledKey = 'weather_reminder_enabled';

  final WeatherForecastService _forecastService;
  final WeatherNotificationService _notificationService;

  bool _isEnabled = false;
  bool _isLoading = false;
  String? _errorMessage;

  bool get isEnabled => _isEnabled;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> setEnabled(bool value) async {
    debugPrint('[WeatherReminderProvider] setEnabled: $value');
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _isEnabled = value;
      await StorageService.instance.setBool(_enabledKey, value);

      if (value) {
        final notificationGranted = await _notificationService
            .requestPermission();
        debugPrint(
          '[WeatherReminderProvider] notificationGranted=$notificationGranted',
        );
        if (!notificationGranted) {
          throw const WeatherPermissionException(
            'Ứng dụng cần quyền thông báo để nhắc thời tiết.',
          );
        }

        await _forecastService.ensureLocationPermission();
        debugPrint('[WeatherReminderProvider] location permission granted');

        await scheduleWeatherReminder();
      } else {
        await _notificationService.cancelForecastReminder();
      }
    } catch (error) {
      debugPrint('[WeatherReminderProvider] setEnabled error: $error');
      _errorMessage = error.toString();
      _isEnabled = false;
      await StorageService.instance.setBool(_enabledKey, false);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> checkNowIfNeeded() async {
    debugPrint(
      '[WeatherReminderProvider] checkNowIfNeeded enabled=$_isEnabled',
    );
    if (!_isEnabled) return;

    try {
      await _notificationService.notifyIfNeeded(
        forecastService: _forecastService,
      );
    } catch (error) {
      debugPrint('[WeatherReminderProvider] checkNowIfNeeded error: $error');
      _errorMessage = error.toString();
      notifyListeners();
    }
  }

  void _load() {
    _isEnabled = StorageService.instance.getBool(_enabledKey);
    debugPrint('[WeatherReminderProvider] load enabled=$_isEnabled');
    if (_isEnabled) {
      Future.microtask(scheduleWeatherReminder);
    }
  }

  Future<void> scheduleWeatherReminder() async {
    debugPrint('[WeatherReminderProvider] scheduleWeatherReminder start');
    if (!_isEnabled) {
      debugPrint('[WeatherReminderProvider] schedule skipped: disabled');
      return;
    }

    try {
      final notificationGranted = await _notificationService
          .requestPermission();
      if (!notificationGranted) {
        throw const WeatherPermissionException(
          'Ứng dụng cần quyền thông báo để nhắc thời tiết.',
        );
      }

      await _forecastService.ensureLocationPermission();

      final scheduledDate = _notificationService.nextSevenPm();
      final forecastDate = scheduledDate.add(const Duration(days: 1));
      final forecast = await _forecastService.getMorningForecastFor(
        forecastDate,
      );
      await _notificationService.scheduleForecastAtNextSevenPm(forecast);
      debugPrint(
        '[WeatherReminderProvider] scheduled weather reminder at 19:00=$scheduledDate, forecastDate=$forecastDate',
      );
    } catch (error) {
      debugPrint(
        '[WeatherReminderProvider] scheduleWeatherReminder error: $error',
      );
      _errorMessage = error.toString();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
