import 'package:consultant_app/view/auth/TabBarScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controllers/constants.dart';
import '../../services/api_services.dart';

class AuthApi {
  // ApiKeys ak = ApiKeys();
  ApiServices service = ApiServices();
  // MainServices ms = MainServices();

  @override
  Future<void> logOut(BuildContext context) async {
    String url = "$baseUrl" "/" "$logOutEndPoint";
    await service.authPostData(url);
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('is_logged_in', false);
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return TabBarScreen();
    }), (r) {
      return false;
    });
  }
}
