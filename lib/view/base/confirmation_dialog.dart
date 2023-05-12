import 'package:flutter/material.dart';

import '../../utils/dimensions.dart';
import '../../utils/styles.dart';

class ConfirmationDialog extends StatelessWidget {
  final String icon;
  final double iconSize;
  final String? title;
  final String description;
  final Function onYesPressed;
  final bool isLogOut;
  final bool hasCancel;
  ConfirmationDialog({
    required this.icon,
    this.iconSize = 50,
    this.title,
    required this.description,
    required this.onYesPressed,
    this.isLogOut = false,
    this.hasCancel = true,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
      child: Padding(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
            child: Image.asset(icon, width: iconSize, height: iconSize),
          ),
          title != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_LARGE),
                  child: Text(
                    title!,
                    textAlign: TextAlign.center,
                    style: poppinsMedium.copyWith(
                        fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                        color: Colors.red),
                  ),
                )
              : SizedBox(),
          Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Text(description,
                style: poppinsMedium.copyWith(
                    fontSize: Dimensions.FONT_SIZE_LARGE),
                textAlign: TextAlign.center),
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
          // GetBuilder<OrderController>(builder: (orderController) {
          //   return !orderController.isLoading
          //       ? Row(children: [
          //           hasCancel
          //               ? Expanded(
          //                   child: TextButton(
          //                   onPressed: () =>
          //                       isLogOut ? onYesPressed() : Get.back(),
          //                   style: TextButton.styleFrom(
          //                     backgroundColor: Theme.of(context)
          //                         .disabledColor
          //                         .withOpacity(0.3),
          //                     minimumSize: Size(1170, 40),
          //                     padding: EdgeInsets.zero,
          //                     shape: RoundedRectangleBorder(
          //                         borderRadius: BorderRadius.circular(
          //                             Dimensions.RADIUS_SMALL)),
          //                   ),
          //                   child: Text(
          //                     isLogOut ? 'yes'.tr : 'no'.tr,
          //                     textAlign: TextAlign.center,
          //                     style: poppinsBold.copyWith(
          //                         color: Theme.of(context)
          //                             .textTheme
          //                             .bodyText1
          //                             ?.color),
          //                   ),
          //                 ))
          //               : SizedBox(),
          //           SizedBox(
          //               width: hasCancel ? Dimensions.PADDING_SIZE_LARGE : 0),
          //           Expanded(
          //               child: CustomButton(
          //             buttonText: isLogOut
          //                 ? 'no'
          //                 : hasCancel
          //                     ? 'yes'
          //                     : 'ok',
          //             // onPressed: () =>
          //             // isLogOut ?
          //             // Get.back() :
          //             // onYesPressed(),
          //             height: 40,
          //           )),
          //         ])
          //       : Center(child: CircularProgressIndicator());
          // }),
        ]),
      ),
    );
  }
}
