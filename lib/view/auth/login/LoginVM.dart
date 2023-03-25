import 'dart:convert';

import 'package:consultant_app/utils/SharedPref.dart';
import 'package:consultant_app/view/auth/login/LoginRepo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/user/UserModel.dart';
import '../../../utils/Constants.dart';
import '../../home/HomeScreen.dart';
import '../../widgets/ShowLoadingDialog.dart';

class LoginVM extends ChangeNotifier {
   LoginRepo repo = LoginRepo();


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
      SharedPref.inst.setString(AppKeys.TOKEN, value.token!);
      SharedPref.inst.setString(AppKeys.USER, json.encode(value));
      SharedPref.inst.setBool(AppKeys.ISLogged, true);
    }).onError((error, stackTrace) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.toString()),
        backgroundColor: Colors.red.shade300,
      ));
    });
  }
}
