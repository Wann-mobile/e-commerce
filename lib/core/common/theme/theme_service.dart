import 'package:e_triad/core/common/app/cache_helper.dart';
import 'package:e_triad/core/services/injection_container_import.dart';
import 'package:flutter/material.dart';

class ThemeService extends ChangeNotifier {
  ThemeService._() {
    _loadThemeMode();
  }
  static ThemeService? _instance;
  static ThemeService get instance => _instance ??= ThemeService._();

  final ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  Future<void> setThemeMode(ThemeMode mode) async {
    sl<CacheHelper>().cacheThemeMode(themeMode);
  }

  Future<void> _loadThemeMode() async {
    sl<CacheHelper>().getThemeMode();
    notifyListeners();
  }

  // Helper method to get current brightness
  Brightness getCurrentBrightness(BuildContext context) {
    switch (_themeMode) {
      case ThemeMode.light:
        return Brightness.light;
      case ThemeMode.dark:
        return Brightness.dark;
      case ThemeMode.system:
        return MediaQuery.platformBrightnessOf(context);
    }
  }
}
