import 'package:flutter/material.dart';

extension StringExt on String {
  Map<String, String> get toAuthHeaders {
    return {
      'Authorization': 'Bearer $this',
      'Content-Type': 'application/json : charset=UTF-8',
    };
  }

  Map<String, String> get toAuthPostHeaders {
    return {
      'Authorization': 'Bearer $this',
      'Content-Type': 'application/json',
    };
  }

  ThemeMode get stringToThemeMode {
    return switch (this) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }


  String toDateOnly() {
    
    return DateTime.parse(this).toIso8601String().split('T').first;
  }


  String get obscureEmail {
    final index = indexOf('@');
    var username = substring(0, index);
    final domain = substring(index + 1);

    username = '${username[0]}****${username[username.length - 1]}';

    return '$username@$domain';
  }

  String get initials {
    if (isEmpty) return '';
    final words = trim().split(' ');

    String initials = '';

    for (int i = 0; i < words.length && i < 2; i++) {
      initials += words[i][0];
    }

    return initials.toUpperCase();
  }
}
