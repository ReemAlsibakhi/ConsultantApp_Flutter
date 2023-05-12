import 'package:consultant_app/model/category/Categories.dart';
import 'package:consultant_app/view/base/custom_border_shape.dart';
import 'package:consultant_app/view/screens/category/category_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../data/remote/response/ApiResponse.dart';
import '../../../lang/ar/AppStrings.dart';
import '../../../utils/colors.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_text.dart';
import '../../base/error_widget.dart';
import '../../base/loading_widget.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CategoryVM>(context, listen: false);

    List<Categories> data = [];

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(right: 16.w, left: 16.w),
        child: Column(
          children: [
            CustomAppBar(
                title: AppStrings.category,
                onTap: () {
                  _returnResult(
                      context, viewModel, data[viewModel.selectedItem - 1]);
                }),
            SizedBox(
              height: 20.h,
            ),
            Consumer<CategoryVM>(
              builder: (context, viewModel, _) {
                switch (viewModel.categoryMain.status) {
                  case Status.LOADING:
                    return LoadingWidget();
                  case Status.ERROR:
                    print("Status :: ERROR ");
                    return MyErrorWidget(
                        viewModel.categoryMain.message ?? "NA");
                  case Status.COMPLETED:
                    print("Status :: COMPLETED");
                    data = viewModel.categoryMain.data!.categories!;
                    return _getCategoryListView(
                        viewModel.categoryMain.data!.categories!, viewModel);
                  default:
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _returnResult(
      BuildContext context, CategoryVM viewModel, Categories result) {
    viewModel.setData(result);
    Navigator.pop(context, result);
  }

  Widget _getCategoryListView(
      List<Categories> statusList, CategoryVM viewModel) {
    return BorderShape(
      widget: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) =>
            _buildCategoryListTile(viewModel, index, statusList),
        separatorBuilder: (context, index) => const SizedBox(
          height: 15,
          child: Divider(
            height: 1,
            color: kDividerColor,
          ),
        ),
        itemCount: statusList.length,
        shrinkWrap: true,
      ),
      valColor: Colors.white,
    );
  }

  ListTile _buildCategoryListTile(
      CategoryVM viewModel, int index, List<Categories> category) {
    return ListTile(
      onTap: () {
        print('category index: $index, id:${category[index].id} ');
        viewModel.updateSelectedItem(index + 1, category[index].id!);
      },
      title: CustomText(category[index].name!, 14.sp, 'Poppins', kBlackColor,
          FontWeight.w400),
      trailing: category[index].id == viewModel.selectedId
          ? IconButton(
              onPressed: () {},
              icon: Image.asset('images/check.png'),
            )
          : null,
    );
  }
}
