import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:htql_app/data/api/auth_api.dart';
import 'package:htql_app/data/api/dio_client.dart';
import 'package:htql_app/data/models/auth/login_response.dart';
import 'package:htql_app/services/avatar_storage_service.dart';
import 'package:htql_app/services/storage_service.dart';

class AuthRepository {
  AuthRepository({
    AuthApi? authApi,
    StorageService? storageService,
    AvatarStorageService? avatarStorageService,
  }) : _authApi = authApi ?? AuthApi(DioClient.create()),
       _storageService = storageService ?? StorageService.instance,
       _avatarStorageService =
           avatarStorageService ?? AvatarStorageService.instance;

  final AuthApi _authApi;
  final StorageService _storageService;
  final AvatarStorageService _avatarStorageService;

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

      return response;
    } on DioException catch (error) {
      throw AuthException(_getDioErrorMessage(error));
    }
  }

  Future<void> logout() async {
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
