
import 'package:flutter/material.dart';
class MyTextButton extends StatelessWidget {
   MyTextButton({Key? key,required this.text,required this.onPressed}) : super(key: key);
  final String text;
   void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
          overlayColor:
          MaterialStateColor.resolveWith(
                  (states) =>const  Color(0Xcbe6ef)),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
              fontSize: 20,
              color: Colors.blue),
        ));
  }
}
