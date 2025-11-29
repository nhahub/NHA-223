

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesKeys {
  static const String token = 'accessToken';


}

class AppSharedPreferences  {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool containsKey(String key) {
    try {
      return _prefs.containsKey(key);
    } catch (e) {
      return false;
    }
  }

  static String? getString(String key) {
    try {
      return _prefs.getString(key);
    } catch (e) {
      return null;
    }
  }

  static Future<bool?> setString(String key, String value) async {
    try {
      return await _prefs.setString(key, value);
    } catch (e) {
      return null;
    }
  }
  static int? getInt(String key) {
    try {
      return _prefs.getInt(key);
    } catch (e) {
      return null;
    }
  }
  static Future<bool?> setInt(String key, int value) async {
    try {
      return await _prefs.setInt(key, value);
    } catch (e) {
      return null;
    }
  }
  static bool? getBool(String key) {
    try {
      return _prefs.getBool(key);
    } catch (e) {
      return null;
    }
  }

  static Future<bool?> setBool(String key, bool value) async {
    try {
      return await _prefs.setBool(key, value);
    } catch (e) {
      return null;
    }
  }

  static double? getDouble(String key) {
    try {
      return _prefs.getDouble(key);
    } catch (e) {
      return null;
    }
  }

  static Future<bool?> setDouble(String key, double value) async {
    try {
      return await _prefs.setDouble(key, value);
    } catch (e) {
      return null;
    }
  }

  static Future<bool?> remove(String key) async {
    try {
      return await _prefs.remove(key);
    } catch (e) {
      return null;
    }
  }

  static Future<bool?> clearAll() async {
    try {
      return await _prefs.clear();
    } catch (e) {
      return null;
    }
  }
}
