import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BorderShape extends StatelessWidget {
  Widget widget;
  Color valColor;
  BorderShape(this.widget, this.valColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: valColor, borderRadius: BorderRadius.all(Radius.circular(22))),
      child: widget,
    );
  }
}
