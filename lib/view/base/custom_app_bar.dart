import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/colors.dart';
import 'custom_text.dart';

class CustomAppBar extends StatelessWidget {
  String title;
  Function() onTap;
  CustomAppBar({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12.h, bottom: 16.h),
      child: Row(
        children: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: CustomText('Cancel', 18, 'Poppins', kLightPrimaryColor,
                  FontWeight.w400)),
          const Spacer(),
          CustomText(title, 18, 'Poppins', kBlackColor, FontWeight.w600),
          const Spacer(),
          TextButton(
              onPressed: onTap,
              child: CustomText(
                  'Done', 18, 'Poppins', kLightPrimaryColor, FontWeight.w600)),
        ],
      ),
    );
  }
}
