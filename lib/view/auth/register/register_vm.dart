import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../model/user/UserModel.dart';
import '../../../utils/Constants.dart';
import '../../../utils/SharedPref.dart';
import '../../home/home_screen.dart';
import '../../widgets/ShowLoadingDialog.dart';
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
      _emailError = 'Please enter your email';
      isValid = false;
    } else if (!UserModel.isEmail(email)) {
      _emailError = 'Please enter a valid email address';
      isValid = false;
    } else {
      _emailError = null;
    }

    if (password.isEmpty) {
      _passwordError = 'Please enter your password';
      isValid = false;
    } else if (password.length < 6) {
      isValid = false;
      _passwordError = 'Password must be at least 6 characters long';
    } else {
      _passwordError = null;
    }
    if (confirmPass.isEmpty) {
      _confirmPasswordError = 'Please enter your confirm password';
      isValid = false;
    } else if (confirmPass.length < 6) {
      isValid = false;
      _confirmPasswordError = 'Password must be at least 6 characters long';
    } else if (password != confirmPass) {
      isValid = false;
      _confirmPasswordError = 'Passwords not match';
    } else {
      _confirmPasswordError = null;
    }
    if (userName.isEmpty) {
      _nameError = 'Please enter your userName';
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

        SharedPref.inst.setString(AppKeys.TOKEN, value!.token!);
        SharedPref.inst.setString(AppKeys.USER, json.encode(value));
        SharedPref.inst.setBool(AppKeys.ISLogged, true);

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
