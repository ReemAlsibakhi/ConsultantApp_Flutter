import 'package:consultant_app/lang/ar/AppStrings.dart';
import 'package:consultant_app/utils/app_constants.dart';
import 'package:consultant_app/view/base/custom_border_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/mail/Tags.dart';
import '../../utils/colors.dart';
import '../screens/tags/tags_vm.dart';
import 'custom_text.dart';

class TagGridList extends StatelessWidget {
  List<Tags> tags;
  String? from;
  TagsVM? viewModel;
  TagGridList(this.tags, {super.key, this.from, this.viewModel});
  @override
  Widget build(BuildContext context) {
    if (tags.isEmpty) {
      return CustomText(AppStrings.notFoundData, 14, 'Poppins', kDarkGreyColor,
          FontWeight.w400);
    }
    return BorderShape(
      widget: GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 5 / 1.8,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.w),
        itemBuilder: (context, i) => _buildTagTile(tags[i], tags, context),
        itemCount: tags.length,
      ),
      valColor: Colors.white,
    );
  }

  _buildTagTile(Tags tag, List<Tags> tagList, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (from == AppConstants.tagFromHome) {
          Navigator.of(context).pushNamed('/MailByTag', arguments: {
            'tag': tag,
            'tagList': tagList,
          });
        }
        if (from == AppConstants.tagFromBox) {
          if (viewModel!.selectedItem.contains(tag.id!)) {
            viewModel!.deleteItem(tag.id!);
          } else {
            viewModel!.addItem(tag.id!);
          }
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: viewModel != null
                ? viewModel!.selectedItem.contains(tag.id!)
                    ? kLightPrimaryColor
                    : kLightGreyColor
                : kLightGreyColor,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Center(
          child: CustomText('# ${tag.name}', 12.sp, 'Poppins', kDarkGreyColor,
              FontWeight.w600),
        ),
      ),
    );
  }
}
