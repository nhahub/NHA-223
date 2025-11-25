

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesKeys {
  static const String token = 'accessToken';


}

class AppSharedPreferences {
  static late SharedPreferences pref;

  static Future<void> init() async {
    pref = await SharedPreferences.getInstance();
  }

  static String? getString(String key) {
    try {
      return pref.getString(key);
    } catch (e) {
      return null;
    }
  }

  static int? getInt(String key) {
    try {
      return pref.getInt(key);
    } catch (e) {
      return null;
    }
  }

  static bool? getBool(String key) {
    try {
      return pref.getBool(key);
    } catch (e) {
      return null;
    }
  }

  static Future<bool?> setDouble(String key, double value) async {
    try {
      return pref.setDouble(key, value);
    } catch (e) {
      return null;
    }
  }

  static double? getDouble(String key) {
    try {
      return pref.getDouble(key);
    } catch (e) {
      return null;
    }
  }

  static Future<bool?> setString(String key, String value) async {
    try {
      return pref.setString(key, value);
    } catch (e) {
      return null;
    }
  }

  static Future<bool?> setInt(String key, int value) async {
    try {
      return pref.setInt(key, value);
    } catch (e) {
      return null;
    }
  }

  static Future<bool?> setBool(String key, bool value) async {
    try {
      return await pref.setBool(key, value);
    } catch (e) {
      return null;
    }
  }

  static Future<bool?> remove(String key) async {
    try {
      return await pref.remove(key);
    } catch (e) {
      return null;
    }
  }

  static Future<bool?> clear() async {
    try {
      return await pref.clear();
    } catch (e) {
      return null;
    }
  }
}
