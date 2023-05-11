import 'package:consultant_app/model/mail/Sender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../model/mail/MailData.dart';
import '../../utils/Constants.dart';
import '../widgets/BorderShape.dart';
import '../widgets/CustomText.dart';
import 'new_inbox_vm.dart';

class NewInboxScreen extends StatelessWidget {
  NewInboxScreen({Key? key}) : super(key: key);

  final senderNameController = TextEditingController();
  final senderPhoneController = TextEditingController();
  final mailTitleController = TextEditingController();
  final mailDescriptionController = TextEditingController();
  final mailDateController = TextEditingController();
  final mailArchiveNoController = TextEditingController();
  final mailDecisionController = TextEditingController();
  final mailActivitiesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NewInboxVM>(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      padding: EdgeInsets.only(right: 16.w, left: 16.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildAppBar(context, viewModel),
            _buildSenderWidget(),
            _buildMailDescriptionWidget(),
            _buildDateArchiveWidget(),
            _buildTagWidget(),
            _buildMailStatusWidget(),
            _buildDecisionWidget(),
            _buildImageWidget(),
            _buildActivityExpansion(context),
            _buildAddActivityBtn(),
          ],
        ),
      ),
    );
  }

  BorderShape _buildAddActivityBtn() {
    return BorderShape(
        Row(
          children: const [
            CircleAvatar(
              radius: 12.0,
              backgroundImage: AssetImage('images/profile.png'),
              backgroundColor: Colors.transparent,
            ),
            SizedBox(
              width: 9,
            ),
            Expanded(
              flex: 1,
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Add new Activity …',
                  hintStyle: TextStyle(
                      color: kLightBlackColor,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            Image(image: AssetImage('images/send.png')),
          ],
        ),
        kLightGreyColor2);
  }

  Widget _buildActivityExpansion(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title:
            CustomText('Activity', 20, 'Poppins', kBlackColor, FontWeight.w600),
        backgroundColor: Colors.transparent,
        children: [
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: (context, index) {
              return Text('Hello');
              // return ActivityTile('hello');
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 7,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMailStatusWidget() {
    return BorderShape(
        Row(
          children: [
            const Image(image: AssetImage('images/status.png')),
            const SizedBox(
              width: 12,
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(
                  Radius.circular(22),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 5, bottom: 5, left: 13, right: 13),
                child: CustomText(
                    ' Inbox', 16, 'Poppins', kBlackColor, FontWeight.w600),
              ),
            ),
            const Spacer(),
            const Image(image: AssetImage('images/arrow_right.png')),
          ],
        ),
        Colors.white);
  }

  Widget _buildSenderWidget() {
    return BorderShape(
        Column(
          children: [
            _buildCustomListTile(
                const Icon(
                  Icons.person,
                  color: kHintGreyColor,
                ),
                'Sender',
                Image.asset('images/info.png'),
                '',
                senderNameController),
            const Divider(),
            _buildCustomListTile(
                const Icon(
                  Icons.phone_android,
                  color: kHintGreyColor,
                ),
                'Phone',
                null,
                '',
                senderPhoneController),
            const Divider(),
            Row(
              children: [
                CustomText(
                    'Category', 14.sp, 'Poppins', kBlackColor, FontWeight.w400),
                const Spacer(),
                CustomText('Other', 12.sp, 'Poppins', kLightBlackColor,
                    FontWeight.w400),
                Image.asset(
                  'images/arrow_right.png',
                  width: 14.w,
                  height: 12.h,
                ),
              ],
            )
          ],
        ),
        Colors.white);
  }

  Widget _buildDateArchiveWidget() {
    return BorderShape(
        Column(
          children: [
            _buildCustomListTile(
                const Icon(
                  Icons.date_range,
                  color: Colors.red,
                ),
                'Date',
                Image.asset('images/arrow_right.png'),
                '2,May, 2023',
                mailDateController),
            const Divider(),
            _buildCustomListTile(
                const Icon(
                  Icons.archive_outlined,
                  color: kHintGreyColor,
                ),
                'Archive Number',
                null,
                'like: 102/2022',
                mailArchiveNoController),
          ],
        ),
        Colors.white);
  }

  Widget _buildMailDescriptionWidget() {
    return BorderShape(
        Column(
          children: [
            TextField(
              controller: mailTitleController,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  fontSize: 16.sp,
                  color: kBlackColor),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Title of Mail',
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    fontSize: 16.sp,
                    color: kHintGreyColor),
              ),
            ),
            const Divider(),
            TextField(
              controller: mailDescriptionController,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                  fontSize: 12.sp,
                  color: kBlackColor),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Description',
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                    fontSize: 12.sp,
                    color: kHintGreyColor),
              ),
            ),
          ],
        ),
        Colors.white);
  }

  Widget _buildDecisionWidget() {
    return BorderShape(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Decision',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  fontSize: 16.sp,
                  color: kBlackColor),
            ),
            TextField(
              controller: mailDecisionController,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                  fontSize: 12.sp,
                  color: kBlackColor),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Add Decision..',
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                    fontSize: 12.sp,
                    color: kHintGreyColor),
              ),
            ),
          ],
        ),
        Colors.white);
  }

  Widget _buildCustomListTile(Icon icon, String hint, Image? iconTrailing,
      String subTitle, TextEditingController controller) {
    return Row(
      children: [
        icon,
        SizedBox(
          width: 10.w,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              subTitle.isEmpty
                  ? TextField(
                      controller: controller,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          fontSize: 14.sp,
                          color: kBlackColor),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hint,
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                            fontSize: 12.sp,
                            color: kHintGreyColor),
                      ),
                    )
                  : Text(
                      hint,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          fontSize: 14.sp,
                          color: kBlackColor),
                    ),
              subTitle.isNotEmpty
                  ? TextField(
                      controller: controller,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          fontSize: 12.sp,
                          color: kBlackColor),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: subTitle,
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins',
                            fontSize: 12.sp,
                            color: hint == 'Date'
                                ? kLightPrimaryColor
                                : kHintGreyColor),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
        iconTrailing ?? Container()
      ],
    );
  }

  Widget _buildAppBar(BuildContext context, NewInboxVM viewModel) {
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
          CustomText('New Inbox', 18, 'Poppins', kBlackColor, FontWeight.w600),
          const Spacer(),
          TextButton(
              onPressed: () {
                viewModel
                    .createSender(
                        Sender(
                            name: senderNameController.text,
                            mobile: senderPhoneController.text,
                            categoryId: '1'),
                        context)
                    .then((value) => {
                          viewModel.createMailRequest(
                              MailData(
                                  subject: mailTitleController.text,
                                  description: mailDescriptionController.text,
                                  senderId: '1',
                                  archiveNumber: mailArchiveNoController.text,
                                  archiveDate: '2023-10-20',
                                  statusId: '1',
                                  decision: mailDecisionController.text),
                              context)
                        });
              },
              child: CustomText(
                  'Done', 18, 'Poppins', kLightPrimaryColor, FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildTagWidget() {
    return BorderShape(
        Row(
          children: [
            const Icon(
              Icons.tag,
              color: kDarkGreyColor,
            ),
            SizedBox(
              width: 10.w,
            ),
            //  TagHorizList(widget.data.tags!),
            const Spacer(),
            Image.asset('images/arrow_right.png')
          ],
        ),
        Colors.white);
  }

  Widget _buildImageWidget() {
    return BorderShape(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Image',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                  fontSize: 16.sp,
                  color: kLightPrimaryColor),
            ),
          ],
        ),
        Colors.white);
  }
}
