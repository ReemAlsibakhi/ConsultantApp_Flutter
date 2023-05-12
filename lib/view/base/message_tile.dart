import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import 'custom_border_shape.dart';
import 'custom_text.dart';

class MessageTile extends StatelessWidget {
  const MessageTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BorderShape(
      widget: Padding(
          padding: EdgeInsets.only(left: 16, top: 19, bottom: 13, right: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 18.0,
                backgroundImage: AssetImage('images/profile.png'),
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(
                width: 9,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText('Hussam', 16, 'Poppins', kBlackColor,
                            FontWeight.w600),
                        Spacer(),
                        CustomText('Today, 11:00 AM', 12, 'Poppins',
                            kHintGreyColor, FontWeight.w600),
                      ],
                    ),
                    CustomText('The issue transferred to AAAA', 14, 'Poppins',
                        kLightBlackColor, FontWeight.w400),
                  ],
                ),
              )
            ],
          )),
      valColor: Colors.white,
      onTap: () {},
    );
  }
}
