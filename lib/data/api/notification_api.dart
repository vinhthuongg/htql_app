import 'package:dio/dio.dart';
import 'package:htql_app/data/models/notification/notification_response.dart';
import 'package:retrofit/retrofit.dart';

part 'notification_api.g.dart';

@RestApi()
abstract class NotificationApi {
  factory NotificationApi(Dio dio, {String baseUrl}) = _NotificationApi;

  @GET('/notifications')
  Future<NotificationResponse> getNotifications({
    @Header('Authorization') required String authorization,
  });
}
