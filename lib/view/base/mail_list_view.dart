import 'package:consultant_app/view/base/mail_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/mail/MailFilter.dart';
import '../../utils/colors.dart';
import 'custom_text.dart';

class MailListView extends StatelessWidget {
  List<MailFilter> mailList;
  MailListView(this.mailList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (mailList.isEmpty) {
      return CustomText(
          'Not found data', 14.sp, 'Poppins', kDarkGreyColor, FontWeight.w400);
    }
    return ListView.builder(
        shrinkWrap: true,
        itemCount: mailList.length,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(bottom: 16.h),
        itemBuilder: (BuildContext context, int idx) {
          return Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              title: CustomText(mailList[idx].title, 20, 'Poppins', kBlackColor,
                  FontWeight.w600),
              backgroundColor: Colors.transparent,
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: mailList[idx].children.length,
                  itemBuilder: (context, index) {
                    return MailTile(mailList[idx].children[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      thickness: 0,
                    );
                  },
                ),
              ],
            ),
          );
        });
  }
}
