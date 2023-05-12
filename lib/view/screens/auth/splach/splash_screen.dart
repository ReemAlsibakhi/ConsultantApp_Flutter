import 'dart:async';

import 'package:consultant_app/lang/ar/AppStrings.dart';
import 'package:consultant_app/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../model/user/User.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/colors.dart';
import '../../home/home_screen.dart';
import '../tab_bar_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogin = false;

  countAndPush() {
    Timer(
      const Duration(milliseconds: 700),
      () async {
        // await SharedPref.inst.getToken() == '' ? isLogin = false : true;
        isLogin = (await SharedPref.inst.getBool(AppConstants.ISLogged))!;
        User? user = await SharedPref.inst.getUserData();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return isLogin ? HomeScreen(user: user!) : TabBarScreen();
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    countAndPush();
    return Scaffold(
      body: Container(
        width: 360.w,
        height: 780.w,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [kPrimaryColor, kLightPrimaryColor],
          ),
        ),
        child: _buildLogo(AppStrings.appName),
      ),
    );
  }
}

Widget _buildLogo(String title) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Image(
        image: AssetImage('images/logo2.png'),
      ),
      Text(
        title,
        style: TextStyle(
          fontSize: 25.sp,
          color: Colors.white,
          fontFamily: 'Gulzar',
        ),
      ),
    ],
  );
}
