import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  StorageService._();

  static final StorageService instance = StorageService._();
  static const String authAccessTokenKey = 'auth_access_token';
  static const String authUserKey = 'auth_user';
  static const String rememberedLoginEnabledKey = 'remembered_login_enabled';
  static const String rememberedUsernameKey = 'remembered_username';
  static const String rememberedPasswordKey = 'remembered_password';

  late final SharedPreferences _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  bool getBool(String key, {bool defaultValue = false}) {
    return _preferences.getBool(key) ?? defaultValue;
  }

  Future<bool> setBool(String key, bool value) {
    return _preferences.setBool(key, value);
  }

  String getString(String key, {String defaultValue = ''}) {
    return _preferences.getString(key) ?? defaultValue;
  }

  Future<bool> setString(String key, String value) {
    return _preferences.setString(key, value);
  }

  int getInt(String key, {int defaultValue = 0}) {
    return _preferences.getInt(key) ?? defaultValue;
  }

  Future<bool> setInt(String key, int value) {
    return _preferences.setInt(key, value);
  }

  Future<bool> remove(String key) {
    return _preferences.remove(key);
  }

  String getAuthAccessToken() {
    return getString(authAccessTokenKey);
  }

  String getAuthUser() {
    return getString(authUserKey);
  }

  Future<void> saveAuthAccessToken(String accessToken) async {
    await setString(authAccessTokenKey, accessToken);
  }

  Future<void> saveAuthUser(String userJson) async {
    await setString(authUserKey, userJson);
  }

  Future<bool> clearAuth() async {
    final results = await Future.wait([
      remove(authAccessTokenKey),
      remove(authUserKey),
    ]);

    return results.every((result) => result);
  }

  bool getRememberedLoginEnabled() {
    return getBool(rememberedLoginEnabledKey);
  }

  String getRememberedUsername() {
    return getString(rememberedUsernameKey);
  }

  String getRememberedPassword() {
    return getString(rememberedPasswordKey);
  }

  Future<void> saveRememberedLogin({
    required String username,
    required String password,
  }) async {
    await Future.wait([
      setBool(rememberedLoginEnabledKey, true),
      setString(rememberedUsernameKey, username),
      setString(rememberedPasswordKey, password),
    ]);
  }

  Future<void> clearRememberedLogin() async {
    await Future.wait([
      setBool(rememberedLoginEnabledKey, false),
      remove(rememberedUsernameKey),
      remove(rememberedPasswordKey),
    ]);
  }
}
