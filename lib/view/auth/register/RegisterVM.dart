import 'package:flutter/material.dart';

import '../../../model/user/UserModel.dart';
import '../../../utils/Constants.dart';
import '../../../utils/SharedPref.dart';
import '../../home/HomeScreen.dart';
import '../../widgets/ShowLoadingDialog.dart';
import 'RegisterRepo.dart';

class RegisterVM extends ChangeNotifier {
  RegisterRepo repo = RegisterRepo();
  SharedPref sharedPref;

  RegisterVM({required this.sharedPref});

  String userToken = '';

  Future<void> setUserToken(String token) async {
    await sharedPref.setToken(token);
    userToken = token;
  }

  Future<String> getUserToken() async {
    userToken = (await sharedPref.getToken())!;
    return userToken;
  }

  Future<UserModel?> registerRequest(
      String email, String pass, String name, BuildContext context) async {
    showLoadingDialog(context);
    repo.register(email, pass, name).then((value) {
      Navigator.pop(context);
      SharedPref().setUserLogin(true);
      setUserToken(value!.token!);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(value!.user!.role!.name!),
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
