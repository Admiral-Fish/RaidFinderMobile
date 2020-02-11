import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  static SharedPreferences _prefereneces;

  static Future<void> init() async {
    _prefereneces = await SharedPreferences.getInstance();
  }

  static String getString(String key) {
    return _prefereneces.getString(key);
  }

  static int getInt(String key) {
    return _prefereneces.getInt(key);
  }

  static setValue(String key, dynamic value) {
    if (value is String) {
      _prefereneces.setString(key, value);
    } else if (value is int) {
      _prefereneces.setInt(key, value);
    }
  }
}