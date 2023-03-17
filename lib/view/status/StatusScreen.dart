import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/remote/response/ApiResponse.dart';
import '../../model/status/StatusMail.dart';
import '../../utils/Constants.dart';
import '../widgets/CustomText.dart';
import '../widgets/LoadingWidget.dart';
import '../widgets/MyErrorWidget.dart';
import 'StatusVM.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final StatusVM viewModel = StatusVM();
    List<StatusMail> data = [];
    return Scaffold(
      backgroundColor: kLightWhiteColor,
      body: SafeArea(
        child: Column(children: [
          //app bar
          ChangeNotifierProvider(
            create: (BuildContext context) => viewModel,
            child: Consumer<StatusVM>(builder: (context, viewModel, _) {
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
                        'Status', 18, 'Poppins', kBlackColor, FontWeight.w600),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(
                              context, data[viewModel.getSelectedItem() - 1]);
                        },
                        child: CustomText('Done', 18, 'Poppins',
                            kLightPrimaryColor, FontWeight.w600)),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(
            height: 55,
          ),
          //body
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            key: UniqueKey(),
            padding:
                const EdgeInsets.only(top: 20, left: 19, right: 19, bottom: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: Column(
              children: [
                Visibility(
                  visible: false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        child: const Text(
                          'Add Status',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            color: kLightPrimaryColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Image(
                          image: AssetImage('images/edit.png'),
                        ),
                        color: Colors.grey,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                ChangeNotifierProvider(
                  create: (BuildContext context) => viewModel,
                  child: Consumer<StatusVM>(builder: (context, viewModel, _) {
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
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

Widget _getStatusListView(List<StatusMail> statusList, StatusVM viewModel) {
  return ListView.separated(
    itemBuilder: (context, index) => ListTile(
      onTap: () {
        viewModel.updateSelectedItem(index + 1);
      },
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(
                int.parse(statusList[index].color!.substring(2), radix: 16))),
      ),
      title: CustomText(
          statusList[index].name!, 16, 'Poppins', kBlackColor, FontWeight.w400),
      trailing: statusList[index].id == viewModel.getSelectedItem()
          ? IconButton(
              onPressed: () {},
              icon: const Image(
                image: AssetImage('images/check.png'),
              ))
          : null,
    ),
    separatorBuilder: (context, index) => const SizedBox(
      height: 15,
      child: Divider(
        height: 1,
        color: kDividerColor,
      ),
    ),
    itemCount: statusList.length,
    shrinkWrap: true,
  );
}
