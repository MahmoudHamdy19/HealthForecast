import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static dynamic getData(String key) {
    return sharedPreferences.get(key);
  }

  static Future<bool?>? removeData(String key) async {
    return await sharedPreferences.remove(key);
  }

  static Future<bool?>? saveData(String key, dynamic value1) async {
    if (value1 is bool) {
      return await sharedPreferences.setBool(key, value1);
    }
    if (value1 is String) {
      return await sharedPreferences.setString(key, value1);
    }
    if (value1 is int) {
      return await sharedPreferences.setInt(key, value1);
    } else {
      return await sharedPreferences.setDouble(key, value1);
    }
  }
}
