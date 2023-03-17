import 'package:consultant_app/view/auth/login/LoginScreen.dart';
import 'package:consultant_app/view/auth/register/RegisterScreen.dart';
import 'package:flutter/material.dart';

import '../../utils/Constants.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Padding(
        padding: const EdgeInsets.only(left: 40, right: 40, top: 60),
        child: Column(
          children: [
            // give the tab bar a height [can change hheight to preferred height]
            Container(
              height: 35,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: kGreyColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
              ),
              child: TabBar(
                // controller: _tabController,
                // give the indicator a decoration (color and border radius)
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                  color: kPrimaryColor,
                ),
                labelColor: Colors.white,
                labelStyle: const TextStyle(
                    color: kPrimaryColor,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600),
                unselectedLabelColor: kPrimaryColor,
                unselectedLabelStyle: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
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
              height: 30,
            ),
            // tab bar view here
            Expanded(
              child: TabBarView(
                // controller: _tabController,
                children: [
                  // first tab bar view widget
                  LoginScreen(),
                  RegisterScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
