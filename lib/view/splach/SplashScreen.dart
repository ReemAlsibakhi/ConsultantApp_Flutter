import 'package:consultant_app/view/auth/TabBarScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/services/main_services.dart';
import '../../utils/Constants.dart';
import '../home/HomeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  MainServices ms = MainServices();
  bool isLogin = false;

  getIsLogIn() async {
    final prefs = await SharedPreferences.getInstance();
    isLogin = prefs.getBool('is_logged_in')!;
  }

  @override
  void initState() {
    getIsLogIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('splach isLogin $isLogin');

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return isLogin == true ? HomeScreen() : TabBarScreen();
      }));
    });
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
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
