import 'package:consultant_app/model/mail/Tags.dart';
import 'package:consultant_app/view/base/tag_grid_list.dart';
import 'package:consultant_app/view/screens/tags/tags_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../data/remote/response/ApiResponse.dart';
import '../../../lang/ar/AppStrings.dart';
import '../../base/custom_app_bar.dart';
import '../../base/error_widget.dart';
import '../../base/loading_widget.dart';

class TagsScreen extends StatelessWidget {
  final String? from;
  TagsScreen({this.from});

  Widget build(BuildContext context) {
    final viewModel = Provider.of<TagsVM>(context, listen: false);
    List<Tags> data = [];

    return Container(
      padding: EdgeInsets.only(right: 16.w, left: 16.w),
      child: Column(
        children: [
          CustomAppBar(
              title: AppStrings.tags,
              onTap: () {
                _returnResult(context, viewModel, viewModel.selectedItem);
              }),
          SizedBox(
            height: 20.h,
          ),
          Column(
            children: [
              Consumer<TagsVM>(
                builder: (context, viewModel, _) {
                  switch (viewModel.tagsMain.status) {
                    case Status.LOADING:
                      return LoadingWidget();
                    case Status.ERROR:
                      return MyErrorWidget(viewModel.tagsMain.message ?? "NA");
                    case Status.COMPLETED:
                      print("Status :: COMPLETED");
                      data = viewModel.tagsMain.data!.tags!;
                      return TagGridList(
                        viewModel.tagsMain.data!.tags!,
                        from: from!,
                        viewModel: viewModel,
                      );
                    default:
                  }
                  return Container();
                },
              ),

              //_buildAddTagTexField(),
            ],
          ),
        ],
      ),
    );
  }

  void _returnResult(BuildContext context, TagsVM viewModel, List<int> result) {
    viewModel.setData(result);
    Navigator.pop(context, result);
  }

  _buildAddTagTexField() {}
}
