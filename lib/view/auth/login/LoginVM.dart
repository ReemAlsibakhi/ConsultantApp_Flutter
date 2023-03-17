import 'package:consultant_app/utils/SharedPref.dart';
import 'package:consultant_app/view/auth/login/LoginRepo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/user/UserModel.dart';
import '../../../utils/Constants.dart';
import '../../home/HomeScreen.dart';
import '../../widgets/ShowLoadingDialog.dart';

class LoginVM extends ChangeNotifier {
  SharedPref sharedPref;
  LoginRepo repo = LoginRepo();

  LoginVM({required this.sharedPref});

  String userToken = '';

  Future<void> setUserToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    userToken = token;
  }

  Future<void> setUserLogin(bool isLogin) async {
    await sharedPref.setUserLogin(isLogin);
    // userToken = token;
  }

  // Future<String> getUserToken() async {
  //   userToken = (await sharedPref.getToken())!;
  //   return userToken;
  // }

  Future<UserModel?> loginRequest(
      String email, String pass, BuildContext context) async {
    showLoadingDialog(context);
    repo.login(email, pass).then((value) async {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(value.user!.role!.name!),
        backgroundColor: kLightPrimaryColor,
      ));
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return HomeScreen();
      }), (r) {
        return false;
      });
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', value.token!);
      prefs.setBool('is_logged_in', true);
    }).onError((error, stackTrace) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.toString()),
        backgroundColor: Colors.red.shade300,
      ));
    });
  }
}
