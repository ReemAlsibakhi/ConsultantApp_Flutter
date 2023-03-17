import 'package:flutter/cupertino.dart';

import '../../../model/mail/Tags.dart';
import '../../../utils/Constants.dart';
import '../CustomText.dart';

class TagHorizList extends StatelessWidget {
  List<Tags>? tags;

  TagHorizList(this.tags, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 27,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: tags!.length,
        itemBuilder: (ctx, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText('#${tags![index].name!}', 14, 'Poppins',
                  kLightPrimaryColor, FontWeight.w600),
              const SizedBox(
                height: 6,
              )
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: 8,
          );
        },
      ),
    );
  }
}
