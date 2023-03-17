import 'package:flutter/material.dart';

import '../../utils/Constants.dart';
import 'CustomText.dart';

class Button extends StatelessWidget {
  Button({required this.title, required this.onPressed});

  String title;
  Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        // margin: const EdgeInsets.symmetric(horizontal: 50),
        padding: const EdgeInsets.only(top: 14, bottom: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [kLightPrimaryColor, kPrimaryColor],
          ),
        ),
        child: Center(
            child: CustomText(
                title, 14, 'Poppins', Colors.white, FontWeight.w600)),
      ),
    );
  }
}
