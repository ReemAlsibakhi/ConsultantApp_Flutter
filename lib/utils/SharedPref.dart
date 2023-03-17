import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static const String SHARED_APP_DATA = "app_data";
  static const String ISLoggedIn = "is_logged_in";
  static const String USER_DATA = "USER_DATA";
  static const String TOKEN = "token";
  static const String SHARED_LANGUAGE = "lang";
  late SharedPreferences _prefs;

  Future<void> getSharedPreferences() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  SharedPref();

  Future<void> setUserLogin(bool isLogin) async {
    await getSharedPreferences();
    _prefs.setBool(ISLoggedIn, isLogin);
  }

  Future<bool?> getUserLogin() async {
    try {
      await getSharedPreferences();
      return _prefs.getBool(ISLoggedIn);
    } catch (e) {
      return false;
    }
  }

  Future<void> setToken(String token) async {
    await getSharedPreferences();
    _prefs.setString(TOKEN, token);
  }

  Future getToken() async {
    String? token;
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString(TOKEN);
    return token;
  }

  // void setUser(UserModel userModel) async {
  //   final SharedPreferences pref = await prefs;
  //   await pref.setString(USER_DATA, userModel.toString());
  // }
  //
  // Future<UserModel?> getUser() async {
  //   final SharedPreferences pref = await prefs;
  //   return UserModel.fromJson(pref.getString(USER_DATA));
  // }
}
