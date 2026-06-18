import 'package:dio/dio.dart';
import 'package:htql_app/data/api/dio_client.dart';
import 'package:htql_app/data/api/notification_api.dart';
import 'package:htql_app/data/models/notification/notification_response.dart';
import 'package:htql_app/services/storage_service.dart';

class NotificationRepository {
  NotificationRepository({
    NotificationApi? notificationApi,
    StorageService? storageService,
  }) : _notificationApi =
           notificationApi ?? NotificationApi(DioClient.create()),
       _storageService = storageService ?? StorageService.instance;

  final NotificationApi _notificationApi;
  final StorageService _storageService;

  Future<NotificationData> getNotifications() async {
    final accessToken = _storageService.getAuthAccessToken();
    if (accessToken.isEmpty) {
      throw const NotificationException('Phiên đăng nhập đã hết hạn');
    }

    try {
      final response = await _notificationApi.getNotifications(
        authorization: 'Bearer $accessToken',
      );

      if (!response.status) {
        throw NotificationException(
          response.message ?? 'Không thể tải thông báo',
        );
      }

      return response.data;
    } on DioException catch (error) {
      throw NotificationException(_getDioErrorMessage(error));
    }
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
        return 'Không thể tải thông báo';
      case DioExceptionType.connectionError:
        return 'Không thể kết nối máy chủ';
      default:
        return 'Không thể tải thông báo, vui lòng thử lại';
    }
  }
}

class NotificationException implements Exception {
  const NotificationException(this.message);

  final String message;

  @override
  String toString() => message;
}
