import 'package:consultant_app/model/mail/Sender.dart';
import 'package:consultant_app/utils/app_constants.dart';
import 'package:consultant_app/view/screens/category/category_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../lang/ar/AppStrings.dart';
import '../../../model/mail/MailData.dart';
import '../../../utils/colors.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_border_shape.dart';
import '../../base/custom_text.dart';
import '../category/category_screen.dart';
import '../status/status_screen.dart';
import '../status/status_vm.dart';
import '../tags/tags_screen.dart';
import '../tags/tags_vm.dart';
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

    return ChangeNotifierProvider(
      create: (_) => StatusVM(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.95,
        padding: EdgeInsets.only(right: 16.w, left: 16.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(
                  title: 'New Inbox',
                  onTap: () {
                    _createMail(context, viewModel);
                  }),
              _buildSenderWidget(),
              _buildMailDescriptionWidget(),
              _buildDateArchiveWidget(),
              _buildTagWidget(),
              _buildMailStatusWidget(context),
              _buildDecisionWidget(),
              _buildImageWidget(),
              _buildActivityExpansion(context),
              _buildAddActivityBtn(),
            ],
          ),
        ),
      ),
    );
  }

  BorderShape _buildAddActivityBtn() {
    return BorderShape(
      widget: Row(
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
                hintText: AppStrings.addActivity,
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
      valColor: kLightGreyColor2,
      onTap: () {},
    );
  }

  Widget _buildActivityExpansion(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: CustomText(
            AppStrings.activity, 20, 'Poppins', kBlackColor, FontWeight.w600),
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

  Widget _buildMailStatusWidget(BuildContext context) {
    return Consumer<StatusVM>(builder: (context, viewModel, _) {
      return BorderShape(
          widget: Row(
            children: [
              Image.asset('images/status.png'),
              const SizedBox(
                width: 12,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(int.parse(viewModel.data != null
                      ? viewModel.data!.color!
                      : '0xfffa3a57')),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(22),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 5, bottom: 5, left: 13, right: 13),
                  child: CustomText(
                      viewModel.data != null
                          ? viewModel.data!.name!
                          : AppStrings.inbox,
                      16,
                      'Poppins',
                      kBlackColor,
                      FontWeight.w600),
                ),
              ),
              const Spacer(),
              const Image(image: AssetImage('images/arrow_right.png')),
            ],
          ),
          valColor: Colors.white,
          onTap: () {
            _navigateToStatusScreen(context, viewModel);
          });
    });
  }

  Widget _buildSenderWidget() {
    return Consumer<CategoryVM>(builder: (context, viewModel, _) {
      return BorderShape(
        widget: Column(
          children: [
            _buildCustomListTile(
                const Icon(
                  Icons.person,
                  color: kHintGreyColor,
                ),
                AppStrings.sender,
                Image.asset('images/info.png'),
                '',
                senderNameController),
            const Divider(),
            _buildCustomListTile(
                const Icon(
                  Icons.phone_android,
                  color: kHintGreyColor,
                ),
                AppStrings.phone,
                null,
                '',
                senderPhoneController),
            const Divider(),
            Consumer<CategoryVM>(builder: (context, viewModel, _) {
              return GestureDetector(
                onTap: () => _navigateToCategoryScreen(context, viewModel),
                child: Row(
                  children: [
                    CustomText(AppStrings.category, 14.sp, 'Poppins',
                        kBlackColor, FontWeight.w400),
                    const Spacer(),
                    CustomText(viewModel.data!.name ?? AppStrings.other, 12.sp,
                        'Poppins', kLightBlackColor, FontWeight.w400),
                    Image.asset(
                      'images/arrow_right.png',
                      width: 14.w,
                      height: 12.h,
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
        valColor: Colors.white,
        onTap: () {},
      );
    });
  }

  Widget _buildDateArchiveWidget() {
    return BorderShape(
      widget: Column(
        children: [
          _buildCustomListTile(
              const Icon(
                Icons.date_range,
                color: Colors.red,
              ),
              AppStrings.date,
              Image.asset('images/arrow_right.png'),
              '2,May, 2023',
              mailDateController),
          const Divider(),
          _buildCustomListTile(
              const Icon(
                Icons.archive_outlined,
                color: kHintGreyColor,
              ),
              AppStrings.archiveNumber,
              null,
              'like: 102/2022',
              mailArchiveNoController),
        ],
      ),
      valColor: Colors.white,
      onTap: () {},
    );
  }

  Widget _buildMailDescriptionWidget() {
    return BorderShape(
      widget: Column(
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
              hintText: AppStrings.titleMail,
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
              hintText: AppStrings.description,
              hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                  fontSize: 12.sp,
                  color: kHintGreyColor),
            ),
          ),
        ],
      ),
      valColor: Colors.white,
      onTap: () {},
    );
  }

  Widget _buildDecisionWidget() {
    return BorderShape(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.decision,
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
              hintText: AppStrings.addDecision,
              hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                  fontSize: 12.sp,
                  color: kHintGreyColor),
            ),
          ),
        ],
      ),
      valColor: Colors.white,
      onTap: () {},
    );
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
                            color: hint == AppStrings.date
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

  Widget _buildTagWidget() {
    return Consumer<TagsVM>(builder: (context, viewModel, _) {
      return BorderShape(
          widget: Row(
            children: [
              const Icon(
                Icons.tag,
                color: kDarkGreyColor,
              ),
              SizedBox(
                width: 10.w,
              ),
              CustomText(
                  AppStrings.tags, 16, 'Poppins', kBlackColor, FontWeight.w600),
              const Spacer(),
              Image.asset('images/arrow_right.png')
            ],
          ),
          valColor: Colors.white,
          onTap: () {
            _navigateToTagScreen(context, viewModel);
          });
    });
  }

  Widget _buildImageWidget() {
    return BorderShape(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.addImage,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins',
                fontSize: 16.sp,
                color: kLightPrimaryColor),
          ),
        ],
      ),
      valColor: Colors.white,
      onTap: () {},
    );
  }

  void _createMail(BuildContext context, NewInboxVM viewModel) {
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
  }

  void _navigateToTagScreen(BuildContext context, TagsVM tagsVM) async {
    final dynamic? result = await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: kLightWhiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.w)),
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(
            heightFactor: 0.9,
            child: TagsScreen(from: AppConstants.tagFromBox));
      },
    );

    if (result != null) {
      tagsVM.setData(result);
      print('result tags in newInbox: $result');
    }
  }

  Future<void> _navigateToStatusScreen(
      BuildContext context, StatusVM _statusVM) async {
    final dynamic? result = await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: kLightWhiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.w)),
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(heightFactor: 0.9, child: StatusScreen());
      },
    );

    if (result != null) {
      _statusVM.setData(result);
      print('result status in newInbox: $result');
    }
  }

  Future<void> _navigateToCategoryScreen(
      BuildContext context, CategoryVM viewModel) async {
    final dynamic? result = await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: kLightWhiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.w)),
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(heightFactor: 0.9, child: CategoryScreen());
      },
    );

    if (result != null) {
      viewModel.setData(result);
      print('result category in newInbox: $result');
    }
  }
}
