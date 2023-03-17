import 'package:consultant_app/utils/Constants.dart';
import 'package:consultant_app/view/widgets/ImageCard.dart';
import 'package:flutter/material.dart';

import '../widgets/CustomText.dart';

class ImageTile extends StatelessWidget {
  // Attachments attachments;
  // ImageTile(this.attachments, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          backgroundColor: kRedColor,
          radius: 12,
          child: Image(
            image: AssetImage('images/delete.png'),
          ),
        ),
        SizedBox(width: 16),
        ImageCard(
            'profiles/o7vKlSNQpAzfK6btul8S9hHmqWo7hUqcVaks5vrv.png', 32, 40),
        SizedBox(
          width: 16,
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Row(
                children: [
                  CustomText(
                      'Image', 16, 'Poppins', kBlackColor, FontWeight.w400),
                  Spacer(),
                  Image(
                    image: AssetImage('images/arrange.png'),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Divider(
                height: 2,
                color: kDividerColor,
              )
            ],
          ),
        )
      ],
    );
  }
}
