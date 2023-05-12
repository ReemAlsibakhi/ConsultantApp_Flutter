import 'package:consultant_app/lang/ar/AppStrings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../data/remote/response/ApiResponse.dart';
import '../../../model/status/StatusMail.dart';
import '../../../utils/colors.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_border_shape.dart';
import '../../base/custom_text.dart';
import '../../base/error_widget.dart';
import '../../base/loading_widget.dart';
import 'status_vm.dart';

class StatusScreen extends StatelessWidget {
  StatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<StatusVM>(context, listen: false);

    List<StatusMail> data = [];

    return Container(
      padding: EdgeInsets.only(right: 16.w, left: 16.w),
      child: Column(
        children: [
          CustomAppBar(
              title: AppStrings.status,
              onTap: () {
                _returnResult(context, viewModel, data[viewModel.selectedItem]);
              }),
          SizedBox(
            height: 20.h,
          ),
          BorderShape(
            widget: Column(
              children: [
                _buildAddStatus(),
                Consumer<StatusVM>(
                  builder: (context, viewModel, _) {
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
                  },
                ),
              ],
            ),
            valColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Visibility _buildAddStatus() {
    return Visibility(
      visible: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            child: const Text(
              AppStrings.addStatus,
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
    );
  }

  void _returnResult(
      BuildContext context, StatusVM viewModel, StatusMail result) {
    viewModel.setData(result);
    Navigator.pop(context, result);
  }
}

Widget _getStatusListView(List<StatusMail> statusList, StatusVM viewModel) {
  return ListView.separated(
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) =>
        _buildStatusListTile(viewModel, index, statusList),
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

ListTile _buildStatusListTile(
    StatusVM viewModel, int index, List<StatusMail> statusList) {
  return ListTile(
    onTap: () {
      viewModel.updateSelectedItem(index, statusList[index].id!);
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
    trailing: statusList[index].id == viewModel.selectedId
        ? IconButton(
            onPressed: () {},
            icon: Image.asset('images/check.png'),
          )
        : null,
  );
}
