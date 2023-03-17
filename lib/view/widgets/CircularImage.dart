import 'package:flutter/cupertino.dart';

import '../../utils/Constants.dart';

class CircularImage extends StatelessWidget {
  String icon;
  // Color color;

  CircularImage(this.icon, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      width: 54,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: kGreyColor),
        borderRadius: BorderRadius.circular(100), //<-- SEE HERE
      ),
      child: Image.asset(this.icon),
    );
  }
}
