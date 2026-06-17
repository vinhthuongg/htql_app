import 'package:dio/dio.dart';
import 'package:htql_app/data/models/auth/login_response.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST('/login')
  @FormUrlEncoded()
  Future<LoginResponse> login({
    @Field('username') required String username,
    @Field('password') required String password,
  });
}
