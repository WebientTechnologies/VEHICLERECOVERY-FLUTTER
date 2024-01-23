import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SaveData {
  static Future<void> saveData({
    String key = '',
    Map<String, dynamic> value = const {},
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, json.encode(value));
  }

  static Future<Map<String, dynamic>> getData({
    String key = '',
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString(key);
    if (value != null) {
      return json.decode(value);
    } else {
      return {};
    }
  }

  static Future<void> deleteData({
    String key = '',
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
