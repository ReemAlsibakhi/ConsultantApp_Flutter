import 'dart:convert';

import 'package:consultant_app/model/user/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user/UserModel.dart';
import 'app_constants.dart';

class SharedPref {
  static SharedPref inst = SharedPref();

  late SharedPreferences _prefs;

  Future<void> onInit() async {
    _prefs = await SharedPreferences.getInstance();
  }

  setString(String key, String value) async {
    _prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    return _prefs.getString(key) ?? '';
  }

  setBool(String key, bool value) async {
    _prefs.setBool(key, value);
  }

  getBool(String key) async {
    return _prefs.getBool(key) ?? false;
  }

  Future<User?> getUserData() async {
    final user = _prefs.getString(AppConstants.USER);
    return user == null ? null : UserModel.fromJson(json.decode(user)).user;
  }

  Future<String> getToken() async {
    final user = _prefs.getString(AppConstants.USER);
    return user == null ? '' : UserModel.fromJson(json.decode(user)).token!;
  }

  Future<bool> clear() async {
    return await _prefs.clear();
  }

  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }
}
