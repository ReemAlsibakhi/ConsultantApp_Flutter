import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BorderShape extends StatelessWidget {
  Widget widget;
  Color valColor;
  BorderShape(this.widget, this.valColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
          color: valColor,
          borderRadius: BorderRadius.all(Radius.circular(22.w))),
      child: widget,
    );
  }
}
