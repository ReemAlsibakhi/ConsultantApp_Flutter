import 'dart:convert';

import 'package:consultant_app/lang/ar/AppStrings.dart';
import 'package:flutter/material.dart';

import '../../../../model/user/UserModel.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/shared_pref.dart';
import '../../../base/custom_loading_dialog.dart';
import '../../home/home_screen.dart';
import 'login_repo.dart';

class LoginVM extends ChangeNotifier {
  LoginRepo repo = LoginRepo();

  UserModel? _user;
  UserModel? get user => _user;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _emailError;
  String? _passwordError;

  String? get emailError => _emailError;
  String? get passwordError => _passwordError;

  bool validateInputs(String email, String password) {
    bool isValid = true;
    if (email.isEmpty) {
      _emailError = AppStrings.enterEmail;
      isValid = false;
    } else if (!UserModel.isEmail(email)) {
      _emailError = AppStrings.enterValidEmail;
      isValid = false;
    } else {
      _emailError = null;
    }

    if (password.isEmpty) {
      _passwordError = AppStrings.enterPassword;
      isValid = false;
    } else if (password.length < 6) {
      isValid = false;
      _passwordError = AppStrings.enterValidPassword;
    } else {
      _passwordError = null;
    }

    notifyListeners();
    return isValid;
  }

  Future<void> loginRequest(
      String email, String pass, BuildContext context) async {
    _isLoading = true;
    showLoadingDialog(context);

    try {
      repo.login(email, pass).then((value) async {
        _isLoading = false;
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(value.user!.role!.name!),
          backgroundColor: kLightPrimaryColor,
        ));

        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return HomeScreen(user: value.user!);
        }), (r) {
          return false;
        });
        SharedPref.inst.setString(AppConstants.TOKEN, value.token!);
        SharedPref.inst.setString(AppConstants.USER, json.encode(value));
        SharedPref.inst.setBool(AppConstants.ISLogged, true);
      }).onError((error, stackTrace) {
        _isLoading = false;
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error.toString()),
          backgroundColor: Colors.red.shade300,
        ));
      });
    } catch (e) {
      _isLoading = false;
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
