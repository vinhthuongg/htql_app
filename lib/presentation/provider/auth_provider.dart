import 'package:flutter/material.dart';
import 'package:htql_app/data/models/auth/login_response.dart';
import 'package:htql_app/repositories/auth_repository.dart';
import 'package:htql_app/services/storage_service.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider({AuthRepository? authRepository, StorageService? storageService})
    : _authRepository = authRepository ?? AuthRepository(),
      _storageService = storageService ?? StorageService.instance {
    _currentUser = _authRepository.cachedUser;
    _isLoggedIn = _authRepository.isLoggedIn;
    _rememberLogin = _storageService.getRememberedLoginEnabled();
  }

  final AuthRepository _authRepository;
  final StorageService _storageService;

  bool _isLoading = false;
  bool _isLoggedIn = false;
  bool _rememberLogin = false;
  String? _errorMessage;
  LoginUser? _currentUser;

  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;
  bool get rememberLogin => _rememberLogin;
  String? get errorMessage => _errorMessage;
  LoginUser? get currentUser => _currentUser;
  String get rememberedUsername => _storageService.getRememberedUsername();
  String get rememberedPassword => _storageService.getRememberedPassword();

  Future<bool> login({
    required String username,
    required String password,
    required bool rememberLogin,
  }) async {
    final cleanedUsername = username.trim();
    final cleanedPassword = password.trim();

    if (cleanedUsername.isEmpty || cleanedPassword.isEmpty) {
      _errorMessage = 'Vui lòng nhập đầy đủ tài khoản và mật khẩu';
      notifyListeners();
      return false;
    }

    _setLoading(true);

    try {
      final response = await _authRepository.login(
        username: cleanedUsername,
        password: cleanedPassword,
      );

      _currentUser = response.data;
      _isLoggedIn = true;
      _rememberLogin = rememberLogin;
      _errorMessage = null;
      await _saveRememberedLogin(
        username: cleanedUsername,
        password: cleanedPassword,
        rememberLogin: rememberLogin,
      );
      _setLoading(false);
      return true;
    } on AuthException catch (error) {
      _errorMessage = error.message;
      _setLoading(false);
      return false;
    } catch (_) {
      _errorMessage = 'Đăng nhập thất bại, vui lòng thử lại';
      _setLoading(false);
      return false;
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    _currentUser = null;
    _isLoggedIn = false;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  Future<void> _saveRememberedLogin({
    required String username,
    required String password,
    required bool rememberLogin,
  }) async {
    if (rememberLogin) {
      await _storageService.saveRememberedLogin(
        username: username,
        password: password,
      );
      return;
    }

    await _storageService.clearRememberedLogin();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
