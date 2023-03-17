import 'package:flutter/cupertino.dart';

class CustomText extends StatelessWidget {
  // CustomText('9', 20, 'Poppins')
  String text;
  double size;
  String fontFamily;
  Color color;
  FontWeight fontWeight;
  CustomText(
      this.text, this.size, this.fontFamily, this.color, this.fontWeight,);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      style: TextStyle(
        fontSize: size,
        fontFamily: fontFamily,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}
