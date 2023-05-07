import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../model/user/UserModel.dart';
import '../../../utils/Constants.dart';
import '../../../utils/SharedPref.dart';
import '../../home/HomeScreen.dart';
import '../../widgets/ShowLoadingDialog.dart';
import 'LoginRepo.dart';

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
          return HomeScreen();
        }), (r) {
          return false;
        });
        SharedPref.inst.setString(AppKeys.TOKEN, value.token!);
        SharedPref.inst.setString(AppKeys.USER, json.encode(value));
        SharedPref.inst.setBool(AppKeys.ISLogged, true);
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

  // Future<void> login(String email, String password) async {
  //   _isLoading = true;
  //   notifyListeners();
  //
  //   try {
  //     _user = await loginA(email, password);
  //   } catch (e) {
  //     print(e.toString());
  //     _isLoading = false;
  //     rethrow;
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }
  //  Future<UserModel> loginA(String email, String password) async {
  //   final response = await http.post(Uri.parse('$login'),
  //       headers: {'Content-Type': 'application/json'},
  //       body:
  //       jsonEncode(<String, String>{'email': email, 'password': password}));
  //
  //   if (response.statusCode == 200) {
  //     print('success');
  //     return UserModel.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('Failed to login');
  //   }
  // }
}
