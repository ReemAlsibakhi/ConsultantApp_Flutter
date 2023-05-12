import 'package:consultant_app/helper/date_converter.dart';
import 'package:consultant_app/model/mail/MailData.dart';
import 'package:flutter/material.dart';

import '../../model/mail/Tags.dart';
import '../../utils/colors.dart';
import 'ImageCard.dart';
import 'custom_text.dart';

class MailTile extends StatelessWidget {
  MailData mailData;
  MailTile(this.mailData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => DetailsScreen(),
        //     settings: RouteSettings(
        //       arguments: mailData,
        //     ),
        //   ),
        // )
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
                CustomText(
                    DateConverter.dateTimeStringToDateOnly(mailData.createdAt!),
                    12.0,
                    'Poppins',
                    kHintGreyColor,
                    FontWeight.w400),
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
                      child: _buildTagHorizontalList(mailData.tags)),
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

  Widget _buildTagHorizontalList(List<Tags>? tags) {
    return SizedBox(
      height: 27,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: tags!.length,
        itemBuilder: (ctx, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText('#${tags![index].name!}', 14, 'Poppins',
                  kLightPrimaryColor, FontWeight.w600),
              const SizedBox(
                height: 6,
              )
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: 8,
          );
        },
      ),
    );
  }
}
