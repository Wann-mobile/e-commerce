import 'package:e_triad/core/common/singleton/cache.dart';
import 'package:e_triad/core/extension/string_ext.dart';
import 'package:e_triad/core/extension/theme_mode_ext.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  const CacheHelper(this._prefs);

  final SharedPreferences _prefs;
  static const _sessionTokenKey = 'user-session-key';
  static const _userIdKey = 'user-Id';
  static const _themeModeKey = 'theme-mode';
  static const _firstTimerKey = 'is-user-first-timer';
  static const _timerKey = 'timer';
  static const _wishlistKey ='wishlist-key';

  Future<bool> cacheSessionToken(String token) async {
    try {
      final results = await _prefs.setString(_sessionTokenKey, token);
      Cache.instance.setSessionToken(token);

      return results;
    } catch (_) {
      return false;
    }
  }

  Future<bool> cacheUserId(String userId) async {
    try {
      final results = await _prefs.setString(_userIdKey, userId);
      Cache.instance.setUserId(userId);
      return results;
    } catch (_) {
      return false;
    }
  }

  Future<void> cacheWishlist(Set<String> wishlist) async{
    await _prefs.setStringList(_wishlistKey, wishlist.toList());
  }

  Future<void> cacheTimer(DateTime timer) async {
    await _prefs.setInt(_timerKey, timer.millisecondsSinceEpoch);
  }

  Future<void> cacheFirstTimer() async {
    await _prefs.setBool(_firstTimerKey, false);
  }

  Future<void> cacheThemeMode(ThemeMode themeMode) async {
    await _prefs.setString(_themeModeKey, themeMode.themeToString);
    Cache.instance.setThemeMode(themeMode);
  }

  String? getSessionToken() {
    final sessionToken = _prefs.getString(_sessionTokenKey);

    if (sessionToken case String()) {
      Cache.instance.setSessionToken(sessionToken);
    } else {
      debugPrint('getSessionToken session does not exist');
    }
    return sessionToken;
  }

  String? getUserId() {
    final userId = _prefs.getString(_userIdKey);
    if (userId case String()) {
      Cache.instance.setUserId(userId);
    } else {
      debugPrint('getUserId userId does not exist');
    }
    return userId;
  }
  List<dynamic>? getWishlist(){
    final wishlist = _prefs.getStringList(_wishlistKey) ?? [];
    return wishlist;
  }

  ThemeMode getThemeMode() {
    final themeModeStringValue = _prefs.getString(_themeModeKey);
    final themeMode =
        themeModeStringValue?.stringToThemeMode ?? ThemeMode.system;
    Cache.instance.setThemeMode(themeMode);
    return themeMode;
  }

  DateTime getCachedStartTimer() {
    final timerMs = _prefs.getInt(_timerKey);
    if (timerMs != null) {
      return DateTime.fromMillisecondsSinceEpoch(timerMs);
    } else {
      return DateTime.now();
    }
  }
  DateTime getCachedEndTimerIn(int minutesDuration){
    final startTimer = getCachedStartTimer();
    return startTimer.add(Duration(minutes: minutesDuration ));
  }

  bool isFirstTime() => _prefs.getBool(_firstTimerKey) ?? true;

  Future<void> resetSession() async {
    await _prefs.remove(_sessionTokenKey);
    await _prefs.remove(_userIdKey);
    Cache.instance.resetSession();
  }
}
