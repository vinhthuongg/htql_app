import 'package:flutter/material.dart';
import 'package:htql_app/repositories/theme_repository.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider({ThemeRepository? themeRepository})
    : _themeRepository = themeRepository ?? ThemeRepository() {
    _isDarkMode = _themeRepository.getIsDarkMode();
  }

  final ThemeRepository _themeRepository;
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  Future<void> toggleDarkMode() async {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
    await _themeRepository.setIsDarkMode(_isDarkMode);
  }
}
