import 'package:consultant_app/model/mail/MailData.dart';
import 'package:consultant_app/model/mail/Sender.dart';
import 'package:flutter/material.dart';

import '../../utils/Constants.dart';
import '../widgets/ShowLoadingDialog.dart';
import 'new_inbox_repo.dart';

class NewInboxVM extends ChangeNotifier {
  NewInboxRepo repo = NewInboxRepo();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _emailError;
  String? _passwordError;

  String? get emailError => _emailError;
  String? get passwordError => _passwordError;

  // bool validateInputs(String email, String password) {
  //   bool isValid = true;
  //   if (email.isEmpty) {
  //     _emailError = 'Please enter your email';
  //     isValid = false;
  //   } else {
  //     _emailError = null;
  //   }
  //
  //   if (password.isEmpty) {
  //     _passwordError = 'Please enter your password';
  //     isValid = false;
  //   } else if (password.length < 6) {
  //     isValid = false;
  //     _passwordError = 'Password must be at least 6 characters long';
  //   } else {
  //     _passwordError = null;
  //   }
  //
  //   notifyListeners();
  //   return isValid;
  // }
  Future<void> createSender(Sender sender, BuildContext context) async {
    print('createSender $sender');
    _isLoading = true;
    showLoadingDialog(context);

    repo.createSender(sender).then((value) async {
      _isLoading = false;
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(value.message!),
        backgroundColor: kLightPrimaryColor,
      ));

      Navigator.pop(context);
    }).onError((error, stackTrace) {
      _isLoading = false;
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.toString()),
        backgroundColor: Colors.red.shade300,
      ));
    });
  }

  Future<void> createMailRequest(
      MailData mailData, BuildContext context) async {
    print('createMailRequest $mailData');
    _isLoading = true;
    //   showLoadingDialog(context);
    print('createMailRequest 2');

    repo.createMail(mailData).then((value) async {
      _isLoading = false;
      // Navigator.pop(context);
      print('createMailRequest 3');

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(value.message!),
        backgroundColor: kLightPrimaryColor,
      ));

      // Navigator.pop(context);
    }).onError((error, stackTrace) {
      _isLoading = false;
      // Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.toString()),
        backgroundColor: Colors.red.shade300,
      ));
    });
  }
}
