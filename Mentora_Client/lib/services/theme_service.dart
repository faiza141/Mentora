import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppTheme { dark, light, synthwave, cyberpunk, forest, valentine, aqua }

class ThemeService {
  static AppTheme _currentTheme = AppTheme.dark;
  static final List<VoidCallback> _listeners = [];
  static SharedPreferences? _prefs;

  static AppTheme get currentTheme => _currentTheme;
  static ThemeData get currentThemeData => _getThemeData(_currentTheme);

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    final savedTheme = _prefs?.getString('app_theme') ?? 'dark';
    _currentTheme = AppTheme.values.firstWhere(
      (e) => e.name == savedTheme,
      orElse: () => AppTheme.dark,
    );
  }

  static Future<void> setTheme(AppTheme theme) async {
    _currentTheme = theme;
    await _prefs?.setString('app_theme', theme.name);
    _notifyListeners();
  }

  static void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  static void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  static void _notifyListeners() {
    for (var listener in _listeners) {
      listener();
    }
  }

  static ThemeData _getThemeData(AppTheme theme) {
    switch (theme) {
      case AppTheme.dark:
        return _darkTheme();
      case AppTheme.light:
        return _lightTheme();
      case AppTheme.synthwave:
        return _synthwaveTheme();
      case AppTheme.cyberpunk:
        return _cyberpunkTheme();
      case AppTheme.forest:
        return _forestTheme();
      case AppTheme.valentine:
        return _valentineTheme();
      case AppTheme.aqua:
        return _aquaTheme();
    }
  }

  static ThemeData _darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      primaryColor: const Color(0xFF2D2D2D),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF2D2D2D),
        secondary: Color(0xFF555555),
        surface: Color(0xFF1A1A1A),
        background: Color(0xFF000000),
      ),
    );
  }

  static ThemeData _lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      primaryColor: const Color(0xFF2D2D2D),
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF2D2D2D),
        secondary: Color(0xFF555555),
        surface: Color(0xFFFFFFFF),
        background: Color(0xFFF5F5F5),
      ),
    );
  }

  static ThemeData _synthwaveTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF1A103D),
      primaryColor: const Color(0xFFE779C1),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFFE779C1),
        secondary: Color(0xFF58C7F3),
        surface: Color(0xFF2A1A5E),
        background: Color(0xFF1A103D),
      ),
    );
  }

  static ThemeData _cyberpunkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0D0D0D),
      primaryColor: const Color(0xFFFFFF00),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFFFFFF00),
        secondary: Color(0xFFFF00FF),
        surface: Color(0xFF1A1A1A),
        background: Color(0xFF0D0D0D),
      ),
    );
  }

  static ThemeData _forestTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF1A1F1A),
      primaryColor: const Color(0xFF7EC97F),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF7EC97F),
        secondary: Color(0xFF4D7C4D),
        surface: Color(0xFF2A3A2A),
        background: Color(0xFF1A1F1A),
      ),
    );
  }

  static ThemeData _valentineTheme() {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFFEE2E2),
      primaryColor: const Color(0xFFE96D7B),
      colorScheme: const ColorScheme.light(
        primary: Color(0xFFE96D7B),
        secondary: Color(0xFFAF4670),
        surface: Color(0xFFFFFFFF),
        background: Color(0xFFFEE2E2),
      ),
    );
  }

  static ThemeData _aquaTheme() {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFE0F2FE),
      primaryColor: const Color(0xFF06B6D4),
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF06B6D4),
        secondary: Color(0xFF0891B2),
        surface: Color(0xFFFFFFFF),
        background: Color(0xFFE0F2FE),
      ),
    );
  }

  static LinearGradient getGradient(AppTheme theme) {
    switch (theme) {
      case AppTheme.dark:
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.07, 0.60, 0.90],
          colors: [Color(0xFF1E1E1E), Color(0xFF000000), Color(0xFF666666)],
        );
      case AppTheme.light:
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF5F5F5), Color(0xFFFFFFFF)],
        );
      case AppTheme.synthwave:
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A103D), Color(0xFF2A1A5E), Color(0xFFE779C1)],
        );
      case AppTheme.cyberpunk:
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0D0D0D), Color(0xFF1A1A1A), Color(0xFFFFFF00)],
        );
      case AppTheme.forest:
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A1F1A), Color(0xFF2A3A2A), Color(0xFF7EC97F)],
        );
      case AppTheme.valentine:
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFEE2E2), Color(0xFFFFFFFF), Color(0xFFE96D7B)],
        );
      case AppTheme.aqua:
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE0F2FE), Color(0xFFFFFFFF), Color(0xFF06B6D4)],
        );
    }
  }

  static String getThemeName(AppTheme theme) {
    switch (theme) {
      case AppTheme.dark:
        return 'Dark';
      case AppTheme.light:
        return 'Light';
      case AppTheme.synthwave:
        return 'Synthwave';
      case AppTheme.cyberpunk:
        return 'Cyberpunk';
      case AppTheme.forest:
        return 'Forest';
      case AppTheme.valentine:
        return 'Valentine';
      case AppTheme.aqua:
        return 'Aqua';
    }
  }

  static Color getTextColor(AppTheme theme) {
    switch (theme) {
      case AppTheme.light:
      case AppTheme.valentine:
      case AppTheme.aqua:
        return Colors.black87;
      default:
        return Colors.white;
    }
  }

  static Color getInputColor(AppTheme theme) {
    switch (theme) {
      case AppTheme.light:
        return const Color(0xFFE8E8E8);
      case AppTheme.valentine:
        return const Color(0xFFFFFFFF);
      case AppTheme.aqua:
        return const Color(0xFFFFFFFF);
      default:
        return const Color(0xFF2D2D2D);
    }
  }

  static Color getButtonColor(AppTheme theme) {
    return currentThemeData.colorScheme.primary;
  }
}
