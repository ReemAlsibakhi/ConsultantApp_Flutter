import 'package:consultant_app/model/mail/MailData.dart';
import 'package:consultant_app/view/details/DetailsScreen.dart';
import 'package:flutter/material.dart';

import '../../utils/Constants.dart';
import '../widgets/CustomText.dart';
import '../widgets/ImageCard.dart';
import '../widgets/listView/TagHorizList.dart';

class MailTile extends StatelessWidget {
  MailData mailData;
  MailTile(this.mailData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(),
            settings: RouteSettings(
              arguments: mailData,
            ),
          ),
        )
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(22))),
        child: Padding(
          padding:
              const EdgeInsets.only(bottom: 9, left: 16, right: 14, top: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Color(int.parse(mailData.status!.color!)),
                  radius: 10,
                ),
                // const Spacer(),
                const SizedBox(
                  width: 9,
                ),
                CustomText(mailData.sender!.name!, 18.0, 'Poppins', kBlackColor,
                    FontWeight.w600),
                const Spacer(),
                CustomText(getDate(mailData.createdAt!), 12.0, 'Poppins',
                    kHintGreyColor, FontWeight.w400),
                const SizedBox(
                  width: 8,
                ),
                const Image(
                  image: AssetImage('images/arrow_right.png'),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 37),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(mailData.subject!, 14.0, 'Poppins', kHintGreyColor,
                      FontWeight.w400),
                  CustomText(mailData.description ?? '', 14.0, 'Poppins',
                      kLightBlackColor, FontWeight.w400),
                  const SizedBox(
                    height: 8,
                  ),
                  Visibility(
                      visible: mailData.tags!.isNotEmpty ? true : false,
                      child: TagHorizList(mailData.tags)),
                  Visibility(
                    visible: mailData.attachments!.isNotEmpty ? true : false,
                    child: SizedBox(
                      height: 36,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: mailData.attachments!.length,
                        itemBuilder: (ctx, index) {
                          return ImageCard(
                              mailData.attachments![index].image!, 36, 36);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
