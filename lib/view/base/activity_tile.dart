import 'package:consultant_app/model/mail/Activities.dart';
import 'package:flutter/material.dart';

import '../../helper/date_converter.dart';
import '../../utils/colors.dart';
import 'custom_border_shape.dart';
import 'custom_text.dart';

class ActivityTile extends StatelessWidget {
  Activities activities;
  ActivityTile(this.activities, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BorderShape(
      widget: Padding(
          padding:
              const EdgeInsets.only(left: 16, top: 19, bottom: 13, right: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 18.0,
                backgroundImage: NetworkImage(activities.user!.image != null
                    ? activities.user!.image!
                    : 'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
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
                        CustomText(activities.user!.name!, 16, 'Poppins',
                            kBlackColor, FontWeight.w600),
                        Spacer(),
                        CustomText(
                            activities.sendDate != null
                                ? DateConverter.dateTimeStringToDateOnly(
                                    activities.sendDate!)
                                : DateConverter.dateTimeStringToDateOnly(
                                    activities.createdAt!),
                            12,
                            'Poppins',
                            kHintGreyColor,
                            FontWeight.w600),
                      ],
                    ),
                    CustomText(activities.body!, 14, 'Poppins',
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
