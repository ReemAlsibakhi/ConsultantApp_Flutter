import 'package:flutter/material.dart';

import '../../utils/Constants.dart';

class customTextField extends StatelessWidget {
  String hintText;
  TextEditingController? controller;
  Icon? icon;
  Icon? preIcon;
  Icon? suffixIcon;
  bool? obsecure;
  InputBorder? border;
  //double? fontSize; // add font size and font weight;
  customTextField(
    this.hintText,
    this.obsecure, {
    this.controller,
    super.key,
    this.preIcon,
    this.suffixIcon,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 262,
      height: 49,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: kGreyColor),
        ),
      ),
      child: TextField(
        obscureText: obsecure!,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: preIcon,
          suffixIcon: suffixIcon,
          icon: icon,
          contentPadding: const EdgeInsets.all(0.0),
          // hintText: hintText,
          label: Text('  $hintText'),
          hintStyle: const TextStyle(
              color: kHintGreyColor, fontSize: 12, fontFamily: 'Poppins'),
          border: border,
        ),
      ),
    );
  }
}
