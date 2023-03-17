import 'package:flutter/material.dart';

import '../../../model/mail/Tags.dart';
import '../../../utils/Constants.dart';
import '../../tiles/TagTile.dart';
import '../CustomText.dart';

class TagGridList extends StatelessWidget {
  List<Tags> tags;
  TagGridList(this.tags);
  @override
  Widget build(BuildContext context) {
    if (tags.isEmpty) {
      return CustomText(
          'Not found data', 14, 'Poppins', kDarkGreyColor, FontWeight.w400);
    }
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(22))),
      child: GridView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(15),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            // maxCrossAxisExtent: 200,
            childAspectRatio: 5 / 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8
            //   childAspectRatio: 1.75,
            ),
        //   multiSelect: true,
        itemBuilder: (context, i) => TagTile(tags[i], tags),
        itemCount: tags.length,
      ),
    );
  }
}
