import 'package:flutter/material.dart';

extension ThemeModeExt on ThemeMode {
  String get themeToString {
    return switch (this) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      _ => 'system',
    };
  }
}
