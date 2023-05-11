import 'package:consultant_app/model/status/StatusMail.dart';
import 'package:consultant_app/view/mails_by_status/mails_by_status_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/Constants.dart';
import '../widgets/CustomText.dart';

class StatusTile extends StatelessWidget {
  StatusTile(this.status);
  StatusMail status;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MailsByStatusScreen(),
            settings: RouteSettings(
              arguments: status,
            ),
          ),
        )
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.0),
        ),
        color: Colors.white,
        elevation: 1,
        child: Padding(
          padding:
              EdgeInsets.only(bottom: 9.h, left: 16.h, right: 14.h, top: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Color(int.parse(status.color!)),
                    radius: 10,
                  ),
                  const Spacer(),
                  CustomText(status.mailsCount!!, 20.0, 'Poppins', kBlackColor,
                      FontWeight.w600),
                ],
              ),
              const SizedBox(height: 14),
              CustomText(status.name!, 18.0, 'Poppins', kHintGreyColor,
                  FontWeight.w600)
            ],
          ),
        ),
      ),
    );
  }
}
