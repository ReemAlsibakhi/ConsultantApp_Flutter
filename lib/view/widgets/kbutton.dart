import 'package:flutter/material.dart';

Widget kTextButton({required Widget widget, required Function() onPressed}) =>
    TextButton(
      onPressed: onPressed,
      child: widget,
    );
