import 'dart:convert';

import 'package:consultant_app/utils/app_constants.dart';
import 'package:flutter/material.dart';

import '../../../../lang/ar/AppStrings.dart';
import '../../../../model/user/UserModel.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/shared_pref.dart';
import '../../../base/custom_loading_dialog.dart';
import '../../home/home_screen.dart';
import 'register_repo.dart';

class RegisterVM extends ChangeNotifier {
  RegisterRepo repo = RegisterRepo();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;
  String? _nameError;

  String? get emailError => _emailError;
  String? get passwordError => _passwordError;
  String? get confirmPasswordError => _confirmPasswordError;
  String? get nameError => _nameError;

  bool validateInputs(
      String email, String password, String confirmPass, String userName) {
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
    if (confirmPass.isEmpty) {
      _confirmPasswordError = AppStrings.enterPassword;
      isValid = false;
    } else if (confirmPass.length < 6) {
      isValid = false;
      _confirmPasswordError = AppStrings.enterValidPassword;
    } else if (password != confirmPass) {
      isValid = false;
      _confirmPasswordError = AppStrings.passwordNotMatch;
    } else {
      _confirmPasswordError = null;
    }
    if (userName.isEmpty) {
      _nameError = AppStrings.enterUserName;
      isValid = false;
    } else {
      _nameError = null;
    }

    notifyListeners();
    return isValid;
  }

  Future<void> registerRequest(
      String email, String pass, String name, BuildContext context) async {
    _isLoading = true;
    showLoadingDialog(context);

    try {
      repo.register(email, pass, name).then((value) async {
        _isLoading = false;
        Navigator.pop(context);

        SharedPref.inst.setString(AppConstants.TOKEN, value!.token!);
        SharedPref.inst.setString(AppConstants.USER, json.encode(value));
        SharedPref.inst.setBool(AppConstants.ISLogged, true);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(value!.user!.role!.name!),
          backgroundColor: kLightPrimaryColor,
        ));
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return HomeScreen(user: value.user!);
        }), (r) {
          return false;
        });
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
