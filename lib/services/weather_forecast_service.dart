import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class MorningRainForecast {
  const MorningRainForecast({
    required this.dateLabel,
    required this.probability,
    required this.precipitation,
  });

  final String dateLabel;
  final int probability;
  final double precipitation;

  bool get willRain => probability >= 40 || precipitation > 0;

  String get title =>
      willRain ? 'Sáng mai có thể có mưa' : 'Sáng mai ít khả năng mưa';

  String get body {
    final rainText = willRain ? 'nên chuẩn bị áo mưa' : 'thời tiết khá ổn';
    return 'Khung 06:00 - 07:00 ngày $dateLabel: khả năng mưa $probability%, lượng mưa ${precipitation.toStringAsFixed(1)}mm, $rainText.';
  }
}

class WeatherPermissionException implements Exception {
  const WeatherPermissionException(this.message);

  final String message;

  @override
  String toString() => message;
}

class WeatherForecastService {
  WeatherForecastService({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  Future<MorningRainForecast> getTomorrowMorningForecast() {
    return getMorningForecastFor(DateTime.now().add(const Duration(days: 1)));
  }

  Future<MorningRainForecast> getMorningForecastFor(
    DateTime forecastDate,
  ) async {
    debugPrint('[WeatherForecast] getMorningForecastFor start');
    final position = await _getCurrentPosition();
    final targetDate = _dateKey(forecastDate);
    final forecastDays = forecastDate.difference(DateTime.now()).inDays + 2;

    debugPrint(
      '[WeatherForecast] position lat=${position.latitude}, lng=${position.longitude}, targetDate=$targetDate, forecastDays=$forecastDays',
    );

    final response = await _dio.get<Map<String, dynamic>>(
      'https://api.open-meteo.com/v1/forecast',
      queryParameters: {
        'latitude': position.latitude,
        'longitude': position.longitude,
        'hourly': 'precipitation_probability,precipitation',
        'timezone': 'auto',
        'forecast_days': forecastDays.clamp(2, 16),
      },
    );

    debugPrint(
      '[WeatherForecast] api status=${response.statusCode}, url=${response.realUri}',
    );

    final data = response.data;
    final hourly = data?['hourly'];
    if (hourly is! Map<String, dynamic>) {
      throw Exception('Không đọc được dữ liệu thời tiết.');
    }

    final times = hourly['time'];
    final probabilities = hourly['precipitation_probability'];
    final precipitations = hourly['precipitation'];
    if (times is! List || probabilities is! List || precipitations is! List) {
      throw Exception('Dữ liệu thời tiết không đúng định dạng.');
    }

    final targetIndex = times.indexWhere(
      (item) => item.toString() == '${targetDate}T06:00',
    );
    debugPrint('[WeatherForecast] targetIndex=$targetIndex');
    if (targetIndex < 0) {
      throw Exception('Không tìm thấy dự báo khung 06:00 - 07:00.');
    }

    final forecast = MorningRainForecast(
      dateLabel: _displayDate(forecastDate),
      probability: _toInt(probabilities[targetIndex]),
      precipitation: _toDouble(precipitations[targetIndex]),
    );
    debugPrint(
      '[WeatherForecast] forecast date=${forecast.dateLabel}, probability=${forecast.probability}, precipitation=${forecast.precipitation}, willRain=${forecast.willRain}',
    );
    return forecast;
  }

  Future<void> ensureLocationPermission() async {
    debugPrint('[WeatherForecast] ensureLocationPermission start');
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    debugPrint('[WeatherForecast] locationServiceEnabled=$serviceEnabled');
    if (!serviceEnabled) {
      throw const WeatherPermissionException(
        'Vui lòng bật Dịch vụ vị trí trên thiết bị.',
      );
    }

    var permission = await Geolocator.checkPermission();
    debugPrint('[WeatherForecast] currentPermission=$permission');
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      debugPrint('[WeatherForecast] requestedPermission=$permission');
    }

    if (permission == LocationPermission.denied) {
      throw const WeatherPermissionException(
        'Ứng dụng cần quyền vị trí để lấy dự báo thời tiết.',
      );
    }

    if (permission == LocationPermission.deniedForever) {
      throw const WeatherPermissionException(
        'Quyền vị trí đang bị chặn. Vui lòng mở Cài đặt để cấp lại quyền.',
      );
    }
  }

  Future<Position> _getCurrentPosition() async {
    await ensureLocationPermission();
    debugPrint('[WeatherForecast] getCurrentPosition start');
    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.low),
    );
    debugPrint('[WeatherForecast] getCurrentPosition completed');
    return position;
  }

  int _toInt(Object? value) {
    if (value is int) return value;
    if (value is num) return value.round();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  double _toDouble(Object? value) {
    if (value is double) return value;
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }

  String _dateKey(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }

  String _displayDate(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }
}
