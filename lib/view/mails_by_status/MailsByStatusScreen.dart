import 'dart:convert';

import 'package:consultant_app/utils/Constants.dart';
import 'package:consultant_app/view/mails_by_status/MailsByStatusVM.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/remote/response/ApiResponse.dart';
import '../../model/mail/Category.dart';
import '../../model/mail/MailData.dart';
import '../../model/mail/MailFilter.dart';
import '../../model/status/StatusMail.dart';
import '../tiles/MailTile.dart';
import '../widgets/CustomText.dart';
import '../widgets/LoadingWidget.dart';
import '../widgets/MyErrorWidget.dart';

List<MailFilter> data = <MailFilter>[];

class MailsByStatusScreen extends StatelessWidget {
  const MailsByStatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MailsByStatusVM vm = MailsByStatusVM();
    StatusMail statusMail =
        ModalRoute.of(context)!.settings.arguments as StatusMail;
    vm.fetchMailsByStatus(statusMail.id!);
    return Scaffold(
      backgroundColor: kLightWhiteColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 16),
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Image(image: AssetImage('images/arrow_left.png')),
                  const SizedBox(
                    width: 8,
                  ),
                  Spacer(),
                  CustomText(statusMail.name!, 18, 'Poppins', kBlackColor,
                      FontWeight.w600),
                  Spacer(),
                ],
                //),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: ChangeNotifierProvider(
                  create: (BuildContext context) => vm,
                  child: Consumer<MailsByStatusVM>(
                    builder: (context, viewModel, _) {
                      switch (viewModel.mailsByStatus.status) {
                        case Status.LOADING:
                          print("mails by status: LOADING");
                          return LoadingWidget();
                        case Status.ERROR:
                          print("mails by status:: ERROR ");
                          return MyErrorWidget(
                              viewModel.mailsByStatus.message ?? "NA");
                        case Status.COMPLETED:
                          print("mails by status: COMPLETED");
                          getMailsByCat(viewModel);
                          return _getMailsList(data);
                        default:
                      }
                      return Container();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<MailFilter>> getMailsByCat(MailsByStatusVM viewModel) async {
  data = <MailFilter>[];
  List<Category> cats = [];
  List<MailData> mails = viewModel.mailsByStatus.data!.status!.mails!;
  List<MailData> tmp = [];
  for (int i = 0; i < mails.length; i++) {
    cats.add(mails[i].sender!.category!);
  }
  // convert each item to a string by using JSON encoding
  final jsonList = cats.map((item) => jsonEncode(item)).toList();
  // using toSet - toList strategy
  final uniqueJsonList = jsonList.toSet().toList();
  // convert each item back to the original form using JSON decoding
  List result = uniqueJsonList.map((item) => jsonDecode(item)).toList();
  List<Category> categories =
      List<Category>.from(result.map((model) => Category.fromJson(model)));

  print('length car ${categories[0].id}');
  for (var item in categories) {
    for (int j = 0; j < mails.length; j++) {
      if (mails[j].sender!.category!.id == item.id) tmp.add(mails[j]);
    }
    data.add(MailFilter(item.name!, tmp));
    tmp = [];
  }

  return data;
}

Widget _getMailsList(List<MailFilter> data) {
  if (data.isEmpty) {
    return CustomText(
        'Not found data', 14, 'Poppins', kDarkGreyColor, FontWeight.w400);
  }
  return ListView.builder(
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (BuildContext context, int idx) {
        return Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            // this.text, this.size, this.fontFamily, this.color, this.fontWeight
            title: CustomText(
                data[idx].title, 20, 'Poppins', kBlackColor, FontWeight.w600),
            backgroundColor: Colors.transparent,
            children: [
              ListView.separated(
                shrinkWrap: true,
                itemCount: data[idx].children.length,
                itemBuilder: (context, index) {
                  return MailTile(data[idx].children[index]);
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
