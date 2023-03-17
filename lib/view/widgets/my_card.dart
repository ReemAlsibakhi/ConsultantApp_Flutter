import 'package:flutter/material.dart';
class MyCard extends StatelessWidget {
  MyCard({Key? key,required this.widget}) : super(key: key);
  Widget widget;
  @override
  Widget build(BuildContext context) {
    return Card(
      //padding: EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: widget
    );
  }
}
