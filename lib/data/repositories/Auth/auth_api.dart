import 'package:consultant_app/view/auth/TabBarScreen.dart';
import 'package:flutter/material.dart';

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
    ms.writeToHiveBox('token', null);
    ms.writeToHiveBox('role', null);
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return TabBarScreen();
    }), (r) {
      return false;
    });
  }
}
