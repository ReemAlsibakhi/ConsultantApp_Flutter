import 'package:flutter/material.dart';

import '../../utils/dimensions.dart';
import '../../utils/styles.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final String buttonText;
  final bool transparent;
  final EdgeInsets margin;
  final double height;
  final double width;
  final double? fontSize;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? fontColor;
  CustomButton(
      {this.onPressed,
      required this.buttonText,
      this.transparent = false,
      this.margin = EdgeInsets.zero,
      this.width = 0.0,
      this.height = 0.0,
      this.fontSize,
      this.icon,
      this.backgroundColor,
      this.fontColor});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle _flatButtonStyle = TextButton.styleFrom(
      backgroundColor: onPressed == null
          ? Theme.of(context).disabledColor
          : transparent
              ? Colors.transparent
              : backgroundColor != null
                  ? backgroundColor
                  : Theme.of(context).primaryColor,
      minimumSize:
          Size(width != 0.0 ? width : 1170, height != 0.0 ? height : 50),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
    );

    return Padding(
      padding: margin == null ? EdgeInsets.all(0) : margin,
      child: TextButton(
        onPressed: onPressed,
        style: _flatButtonStyle,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          icon != null
              ? Icon(
                  icon,
                  color: transparent
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).cardColor,
                  size: 20,
                )
              : SizedBox(),
          SizedBox(
              width: icon != null ? Dimensions.PADDING_SIZE_EXTRA_SMALL : 0),
          Text(buttonText ?? '',
              textAlign: TextAlign.center,
              style: poppinsBold.copyWith(
                color: transparent
                    ? Theme.of(context).primaryColor
                    : fontColor != null
                        ? fontColor
                        : Theme.of(context).cardColor,
                fontSize:
                    fontSize != null ? fontSize : Dimensions.FONT_SIZE_LARGE,
              )),
        ]),
      ),
    );
  }
}
