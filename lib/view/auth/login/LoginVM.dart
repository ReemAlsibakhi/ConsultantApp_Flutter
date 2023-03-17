import 'package:consultant_app/utils/SharedPref.dart';
import 'package:consultant_app/view/auth/login/LoginRepo.dart';
import 'package:flutter/material.dart';

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
    await sharedPref.setToken(token);
    userToken = token;
  }
  //
  // Future<String> getUserToken() async {
  //   userToken = (await sharedPref.getToken())!;
  //   return userToken;
  // }

  Future<UserModel?> loginRequest(
      String email, String pass, BuildContext context) async {
    showLoadingDialog(context);
    repo.login(email, pass).then((value) {
      Navigator.pop(context);
      print('token loginRequest${value.token}');
      SharedPref().setUserLogin(true);
      setUserToken(value.token!);
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
    }).onError((error, stackTrace) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.toString()),
        backgroundColor: Colors.red.shade300,
      ));
    });
  }
}
