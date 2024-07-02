import 'package:shared_preferences/shared_preferences.dart';

class CachMemory {
  static late SharedPreferences sharedPref;

  static Future cachMemoryInit() async {
    sharedPref = await SharedPreferences.getInstance();
  }

  //set int
  static Future<bool> insertIntToCachMemory(
      {required String key, required int value}) async {
    return await sharedPref.setInt(key, value);
  }

// set String
  static Future<bool> insertStringToCachMemory(
      {required String key, required String value}) async {
    return await sharedPref.setString(key, value);
  }

// get int
  static int? getIntFromCachMemory({required String key}) {
    return sharedPref.getInt(key) ?? 0;
  }

// get String
  static String getStringFromCachMemory({required String key}) {
    return sharedPref.getString(key) ?? '';
  }

//delete value
  static Future<bool> deleteFromCachMemory({required key}) async {
    return await sharedPref.remove(key);
  }
}
