import 'package:consultant_app/view/mails_by_tag/MailsByTagVM.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/remote/response/ApiResponse.dart';
import '../../model/mail/Tags.dart';
import '../../model/tags/TagModel.dart';
import '../../utils/Constants.dart';
import '../tiles/MailTile.dart';
import '../widgets/CustomText.dart';
import '../widgets/LoadingWidget.dart';
import '../widgets/MyErrorWidget.dart';

class MailsByTagScreen extends StatelessWidget {
  const MailsByTagScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MailsByTagVM vm = MailsByTagVM();
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    vm.addItem(routeArgs['tag'].id!);
    return Scaffold(
      backgroundColor: kLightWhiteColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 60,
              padding: const EdgeInsets.only(left: 20, right: 20, top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Image(image: AssetImage('images/arrow_left.png')),
                  const SizedBox(
                    width: 8,
                  ),
                  Spacer(),
                  CustomText(
                      'Tags', 18, 'Poppins', kBlackColor, FontWeight.w600),
                  Spacer(),
                ],
                //),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _tagListWidget(routeArgs['tagList'], vm),
                    const SizedBox(
                      height: 16,
                    ),
                    ChangeNotifierProvider(
                      create: (BuildContext context) => vm,
                      child: Consumer<MailsByTagVM>(
                        builder: (context, viewModel, _) {
                          switch (viewModel.mailsByTag.status) {
                            case Status.LOADING:
                              print("mails by status: LOADING");
                              return LoadingWidget();
                            case Status.ERROR:
                              print("mails by status:: ERROR ");
                              return MyErrorWidget(
                                  viewModel.mailsByTag.message ?? "NA");
                            case Status.COMPLETED:
                              print("mails by status: COMPLETED");
                              return _getMailsList(
                                  viewModel.mailsByTag.data!.tags);
                            // viewModel.mailsByTag.data!.tags![0].mails!);
                            default:
                          }
                          return Container();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getMailsList(List<TagModel>? mails) {
    if (mails!.isEmpty) {
      return CustomText(
          'Not found data', 14, 'Poppins', kDarkGreyColor, FontWeight.w400);
    }
    return ListView.separated(
      shrinkWrap: true,
      itemCount: mails[0].mails!.length,
      itemBuilder: (BuildContext context, int idx) {
        return MailTile(mails[0].mails![idx]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 16,
        );
      },
    );
  }

  Widget _tagListWidget(List<Tags> tags, MailsByTagVM vm) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(22))),
      child: GridView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(15),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 5 / 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8
            //   childAspectRatio: 1.75,
            ),
        //   multiSelect: true,
        itemBuilder: (context, i) => _tagTileWidget(tags[i], i, vm),
        itemCount: tags.length,
      ),
    );
  }

  Widget _tagTileWidget(Tags tag, int index, MailsByTagVM vm) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => vm,
      child: Consumer<MailsByTagVM>(builder: (context, viewModel, _) {
        return Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 0,
          child: GestureDetector(
            onTap: () {
              if (viewModel.getSelectedItem().contains(tag.id!)) {
                viewModel.deleteItem(tag.id!);
              } else {
                viewModel.addItem(tag.id!);
              }
            },
            child: Container(
              // padding: const EdgeInsets.only(
              //     top: 6, bottom: 6, right: 12, left: 12),
              color: viewModel.getSelectedItem().contains(tag.id!)
                  ? kLightPrimaryColor
                  : kLightGreyColor,
              child: Center(
                child: CustomText('# ${tag.name}', 14, 'Poppins',
                    kDarkGreyColor, FontWeight.w600),
              ),
            ),
          ),
        );
      }),
    );
  }
}
