import 'dart:convert';

import 'package:consultant_app/view/base/mail_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../data/remote/response/ApiResponse.dart';
import '../../../model/filter/SearchPost.dart';
import '../../../model/mail/Category.dart';
import '../../../model/mail/MailData.dart';
import '../../../model/mail/MailFilter.dart';
import '../../../utils/colors.dart';
import '../../base/custom_search.dart';
import '../../base/custom_text.dart';
import '../../base/error_widget.dart';
import '../../base/loading_widget.dart';
import '../filter/filter_screen.dart';
import '../filter/filter_vm.dart';
import 'SearchVM.dart';

List<MailFilter> data = <MailFilter>[];
SearchVM vm = SearchVM();

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightWhiteColor,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              SizedBox(
                height: 60,
                child: Row(
                  children: [
                    const Image(image: AssetImage('images/arrow_left.png')),
                    const SizedBox(
                      width: 8,
                    ),
                    CustomText('Search', 18, 'Poppins', kLightPrimaryColor,
                        FontWeight.w400),
                  ],
                  //),
                ),
              ),
              Row(
                children: [
                  Expanded(child: CustomSearch(vm)),
                  const SizedBox(
                    width: 17,
                  ),
                  ChangeNotifierProvider(
                    create: (context) => FilterVM(),
                    child: MyParentWidget(),
                  ),
                ],
              ),
              Row(
                children: [
                  ChangeNotifierProvider(
                    create: (BuildContext context) => vm,
                    child: Consumer<SearchVM>(builder: (context, viewModel, _) {
                      return CustomText('${vm.getLength()} Completed ', 14,
                          'Poppins', kDarkGreyColor, FontWeight.w400);
                    }),
                  ),
                  Spacer(),
                  TextButton(
                    child: CustomText('Show ', 14, 'Poppins',
                        kLightPrimaryColor, FontWeight.w400),
                    onPressed: () {},
                  ),
                ],
              ),
              const Divider(
                height: 0.5,
                color: kDividerColor,
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(top: 30),
                  child: ChangeNotifierProvider(
                    create: (BuildContext context) => vm,
                    child: Consumer<SearchVM>(
                      builder: (context, viewModel, _) {
                        switch (viewModel.mailsByFilter.status) {
                          case Status.STOP:
                            print("mails by filter: STOP");
                            return Container();
                          case Status.LOADING:
                            print("mails by filter: Loading");
                            return LoadingWidget();
                          case Status.ERROR:
                            print("mails by filter:: ERROR ");
                            return MyErrorWidget(
                                viewModel.mailsByFilter.message ?? "NA");
                          case Status.COMPLETED:
                            print("mails by filter: COMPLETED");
                            getMailsByFilter(viewModel);
                            return MailListView(data);
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
      ),
    );
  }
}

class MyParentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myDataModel = Provider.of<FilterVM>(context);
    print('MyParentWidget ${myDataModel.getSelectedStatus()}');
    vm.setStatusId(myDataModel.getSelectedStatus());
    return MyChildWidget(
      viewModel: myDataModel,
    );
  }
}

class MyChildWidget extends StatelessWidget {
  final FilterVM viewModel;

  MyChildWidget({required this.viewModel});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          var result = await showModalBottomSheet<SearchPost>(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.w)),
            builder: (BuildContext context) {
              return FractionallySizedBox(
                heightFactor: 0.9,
                child: FilterScreen(viewModel: viewModel),
              );
            },
          );
          print('result from bottom: $result');
          vm.getMailsByFilter();
          viewModel.updateSelectedStatus(result!.statusId ?? -1);
          viewModel.updateSelectedCats(result.catId ?? -1);
        },
        child: const Image(image: AssetImage('images/filter.png')));
  }
}

Future<List<MailFilter>> getMailsByFilter(SearchVM viewModel) async {
  data = <MailFilter>[];
  List<Category> cats = [];
  List<MailData> mails = viewModel.mailsByFilter.data!.mails!;
  viewModel.setLength(mails.length);

  print('Mails length search ${mails.length}');
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
