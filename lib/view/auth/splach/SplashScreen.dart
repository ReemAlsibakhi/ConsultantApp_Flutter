import 'dart:async';

import 'package:consultant_app/utils/SharedPref.dart';
import 'package:consultant_app/view/auth/TabBarScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/services/main_services.dart';
import '../../../utils/Constants.dart';
import '../../home/HomeScreen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  MainServices ms = MainServices();
  bool isLogin = false;

  countAndPush(){
    Timer(Duration(milliseconds: 700), ()async {
      await SharedPref.inst.getToken() == '' ? isLogin = false : true;
      Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (BuildContext context) {
      return isLogin ? HomeScreen() : TabBarScreen();
      },),);
    },);
  }

  @override
  Widget build(BuildContext context) {
    print('splach isLogin $isLogin');
    countAndPush();
    //
    return Scaffold(
      body: Container(
        decoration:   BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [kPrimaryColor, kLightPrimaryColor],
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(
              image: AssetImage('images/logo2.png'),
            ),
            Text(
              'Complaints App',
              style: TextStyle(
                fontSize: 31,
                color: Colors.white,
                fontFamily: 'Gulzar',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
