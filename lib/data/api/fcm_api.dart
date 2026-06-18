import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'fcm_api.g.dart';

@RestApi()
abstract class FcmApi {
  factory FcmApi(Dio dio, {String baseUrl}) = _FcmApi;

  @POST('/notifications/save-token')
  Future<void> saveToken({
    @Header('Authorization') required String authorization,
    @Header('Content-Type') String contentType = 'application/json',
    @Body() required Map<String, dynamic> body,
  });

  @POST('/notifications/delete-token')
  Future<void> deleteToken({
    @Header('Authorization') required String authorization,
    @Header('Content-Type') String contentType = 'application/json',
    @Body() required Map<String, dynamic> body,
  });
}
