import 'dart:async';

import 'package:consultant_app/utils/SharedPref.dart';
import 'package:consultant_app/view/auth/TabBarScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/Constants.dart';
import '../../home/HomeScreen.dart';

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
        isLogin = (await SharedPref.inst.getBool(AppKeys.ISLogged))!;
        // print('isLogin: $isLogin');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return isLogin ? HomeScreen() : TabBarScreen();
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
        child: _buildLogo('Complaints App'),
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
