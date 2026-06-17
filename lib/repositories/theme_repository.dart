import 'package:htql_app/services/storage_service.dart';

class ThemeRepository {
  ThemeRepository({StorageService? storageService})
    : _storageService = storageService ?? StorageService.instance;

  static const String _isDarkModeKey = 'is_dark_mode';

  final StorageService _storageService;

  bool getIsDarkMode() {
    return _storageService.getBool(_isDarkModeKey);
  }

  Future<void> setIsDarkMode(bool value) async {
    await _storageService.setBool(_isDarkModeKey, value);
  }
}
