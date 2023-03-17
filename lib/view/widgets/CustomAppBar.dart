import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/Constants.dart';
import 'CustomText.dart';

class CustomAppBar extends StatelessWidget {
  String title;
  // String leadingIcon;
  // String trailingIcon;
  // bool isNet;
  CustomAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 16, left: 16),
      height: 50,
      child: Row(
        children: [
          const Image(image: AssetImage('images/arrow_left.png')),
          const SizedBox(
            width: 8,
          ),
          CustomText(title, 18, 'Poppins', kLightPrimaryColor, FontWeight.w600),
          const Spacer(),
          const Image(image: AssetImage('images/more.png')),
        ],
        //),
      ),
    );
  }
}
