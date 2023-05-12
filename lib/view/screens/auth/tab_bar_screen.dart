import 'package:consultant_app/view/screens/auth/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/colors.dart';
import 'login/login_screen.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({Key? key}) : super(key: key);

  @override
  _MyTabPageState createState() => _MyTabPageState();
}

class _MyTabPageState extends State<TabBarScreen>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightWhiteColor,
      body: Stack(
        children: [
          _buildLogo(),
          _buildCustomTabBar(context),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      height: 250.h,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
          colors: [kLightPrimaryColor, kPrimaryColor],
        ),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(70.w),
            bottomRight: Radius.circular(70.w)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image(
            image: const AssetImage('images/logo2.png'),
            height: 75.w,
            width: 56.w,
          ),
          Text(
            'Consultant App',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontFamily: 'Gulzar',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomTabBar(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * .25,
        right: 30.0,
        left: 30.0,
        bottom: _isExpanded
            ? MediaQuery.of(context).size.height * .09
            : MediaQuery.of(context).size.height * .20,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(35.w))),
        child: DefaultTabController(
          length: 2,
          child: Padding(
            padding: EdgeInsets.only(left: 40.w, right: 40.w, top: 50.w),
            child: Column(
              children: [
                Container(
                  height: 35.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: kGreyColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(
                      25.0.w,
                    ),
                  ),
                  child: TabBar(
                    onTap: (_) {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    // give the indicator a decoration (color and border radius)
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        25.0.w,
                      ),
                      color: kPrimaryColor,
                    ),
                    labelColor: Colors.white,
                    labelStyle: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 12.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600),
                    unselectedLabelColor: kPrimaryColor,
                    unselectedLabelStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400),
                    tabs: const [
                      Tab(
                        child: Text('Log In'),
                      ),
                      Tab(
                        child: Text('Sign Up'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      LoginScreen(),
                      RegisterScreen(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
