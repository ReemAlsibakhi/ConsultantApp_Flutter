import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../utils/Constants.dart';
import '../../../utils/SharedPref.dart';
import '../../home/HomeScreen.dart';
import '../../widgets/ShowLoadingDialog.dart';
import 'RegisterRepo.dart';

class RegisterVM extends ChangeNotifier {
  RegisterRepo repo = RegisterRepo();

  Future<void> registerRequest(
      String email, String pass, String name, BuildContext context) async {
    showLoadingDialog(context);
    repo.register(email, pass, name).then((value) async {
      Navigator.pop(context);
      SharedPref.inst.setString(AppKeys.TOKEN, value.token!);
      SharedPref.inst.setString(AppKeys.USER, json.encode(value));
      SharedPref.inst.setBool(AppKeys.ISLogged, true);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(value.user!.role!.name!),
        backgroundColor: kLightPrimaryColor,
      ));
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return const HomeScreen();
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
