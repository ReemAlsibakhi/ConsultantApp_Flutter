import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPrefDataSource {
  Future<void> setString(String key, String value);
  Future<String?> getString(String key);
  Future<void> remove(String key);
}

class SharedPref implements SharedPrefDataSource {
  final SharedPreferences sharedPreferences;

  SharedPref(this.sharedPreferences);

  @override
  Future<void> setString(String key, String value) async {
    await sharedPreferences.setString(key, value);
  }

  @override
  Future<String?> getString(String key) async {
    return sharedPreferences.getString(key);
  }

  @override
  Future<void> remove(String key) async {
    await sharedPreferences.remove(key);
  }
}
