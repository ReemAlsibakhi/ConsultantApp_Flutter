import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BorderShape extends StatelessWidget {
  final Widget widget;
  final Color valColor;
  final Function()? onTap;
  const BorderShape(
      {Key? key, required this.widget, required this.valColor, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.w),
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
            color: valColor,
            borderRadius: BorderRadius.all(Radius.circular(22.w))),
        child: widget,
      ),
    );
  }
}
