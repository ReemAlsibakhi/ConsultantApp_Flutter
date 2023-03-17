import 'package:consultant_app/model/category/Categories.dart';
import 'package:consultant_app/model/filter/SearchPost.dart';
import 'package:consultant_app/view/widgets/LoadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/remote/response/ApiResponse.dart';
import '../../model/status/StatusMail.dart';
import '../../utils/Constants.dart';
import '../widgets/CustomText.dart';
import '../widgets/MyErrorWidget.dart';
import 'FilterVM.dart';

class FilterScreen extends StatelessWidget {
  // const FilterScreen({Key? key}) : super(key: key);
  final FilterVM viewModel;

  FilterScreen({required this.viewModel});
  @override
  Widget build(BuildContext context) {
    // final FilterVM viewModel = FilterVM();
    List<StatusMail> data = [];

    return Scaffold(
      backgroundColor: kLightWhiteColor,
      body: SafeArea(
        child: Column(children: [
          //app bar
          ChangeNotifierProvider(
            create: (BuildContext context) => viewModel,
            child: Consumer<FilterVM>(builder: (context, viewModel, _) {
              return Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: CustomText('Cancel', 18, 'Poppins',
                            kLightPrimaryColor, FontWeight.w400)),
                    CustomText(
                        'Filter', 18, 'Poppins', kBlackColor, FontWeight.w600),
                    TextButton(
                        onPressed: () {
                          print('pop ${viewModel.getSelectedStatus()}');
                          Navigator.pop(
                              context,
                              SearchPost(viewModel.getSelectedStatus(),
                                  viewModel.getSelectedCats()));
                          // Navigator.pop(
                          //     context, data[viewModel.getSelectedItem() - 1]);
                        },
                        child: CustomText('Done', 18, 'Poppins',
                            kLightPrimaryColor, FontWeight.w600)),
                  ],
                ),
              );
            }),
          ),
          //body
          Expanded(
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    ChangeNotifierProvider(
                      create: (BuildContext context) => viewModel,
                      child:
                          Consumer<FilterVM>(builder: (context, viewModel, _) {
                        switch (viewModel.statusMain.status) {
                          case Status.LOADING:
                            print("Status :: LOADING");
                            return LoadingWidget();
                          case Status.ERROR:
                            print("Status :: ERROR ");
                            return MyErrorWidget(
                                viewModel.statusMain.message ?? "NA");
                          case Status.COMPLETED:
                            print("Status :: COMPLETED");
                            data = viewModel.statusMain.data!.status!;
                            return _getStatusListView(
                                viewModel.statusMain.data!.status!, viewModel);
                          default:
                        }
                        return Container();
                      }),
                    ),
                    const SizedBox(height: 16),
                    ChangeNotifierProvider(
                      create: (BuildContext context) => viewModel,
                      child:
                          Consumer<FilterVM>(builder: (context, viewModel, _) {
                        switch (viewModel.catMain.status) {
                          case Status.LOADING:
                            print("Status :: LOADING");
                            return LoadingWidget();
                          case Status.ERROR:
                            print("Status :: ERROR ");
                            return MyErrorWidget(
                                viewModel.statusMain.message ?? "NA");
                          case Status.COMPLETED:
                            print("Status :: COMPLETED");
                            //  data = viewModel.catMain.data!.categories!;
                            return _getCategoryListView(
                                viewModel.catMain.data!.categories, viewModel);
                          default:
                        }
                        return Container();
                      }),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 17),
                      // padding: const EdgeInsets.only(
                      //     top: 20, left: 16, right: 16, bottom: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      child: ListTile(
                        leading:
                            Image(image: AssetImage('images/datePicker.png')),
                        title: CustomText('Date', 16, 'Poppins', kBlackColor,
                            FontWeight.w400),
                        subtitle: Row(
                          children: [
                            CustomText('From: ', 12, 'Poppins', kDarkGreyColor,
                                FontWeight.w400),
                            CustomText('July 5, 2022', 12, 'Poppins',
                                kLightPrimaryColor, FontWeight.w400),
                            const SizedBox(
                              width: 20,
                            ),
                            CustomText('To: ', 12, 'Poppins', kDarkGreyColor,
                                FontWeight.w400),
                            CustomText('July 5, 2022', 12, 'Poppins',
                                kLightPrimaryColor, FontWeight.w400),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ]),
      ),
    );
  }
}

Widget _getCategoryListView(List<Categories>? categories, FilterVM viewModel) {
  return Container(
    padding: const EdgeInsets.only(top: 20, left: 19, right: 19, bottom: 20),
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(30)),
    child: ListView.separated(
      itemBuilder: (context, index) =>
          _getCategoryTile(categories[index], viewModel),
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 15,
          child: Divider(
            height: 1,
            color: kDividerColor,
          ),
        );
      },
      itemCount: categories!.length,
      shrinkWrap: true,
    ),
  );
}

_getCategoryTile(Categories categories, FilterVM viewModel) {
  return ListTile(
    onTap: () {
      viewModel.updateSelectedCats(categories.id!);
    },
    title: CustomText(
        categories.name!, 16, 'Poppins', kBlackColor, FontWeight.w400),
    trailing: categories.id == viewModel.getSelectedCats()
        ? IconButton(
            onPressed: () {},
            icon: const Image(
              image: AssetImage('images/check.png'),
            ))
        : null,
  );
}

Widget _getStatusListView(List<StatusMail> statusList, FilterVM viewModel) {
  return Container(
    padding: const EdgeInsets.only(top: 20, left: 19, right: 19, bottom: 20),
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(30)),
    child: ListView.separated(
      itemBuilder: (context, index) =>
          _getStatusTile(statusList[index], viewModel),
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 15,
          child: Divider(
            height: 1,
            color: kDividerColor,
          ),
        );
      },
      itemCount: statusList.length,
      shrinkWrap: true,
    ),
  );
}

Widget _getStatusTile(StatusMail status, FilterVM viewModel) {
  return ListTile(
    onTap: () {
      viewModel.updateSelectedStatus(status.id!);
    },
    leading: Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(int.parse(status.color!.substring(2), radix: 16))),
    ),
    title:
        CustomText(status.name!, 16, 'Poppins', kBlackColor, FontWeight.w400),
    trailing: status.id == viewModel.getSelectedStatus()
        ? IconButton(
            onPressed: () {},
            icon: const Image(
              image: AssetImage('images/check.png'),
            ))
        : null,
  );
}
