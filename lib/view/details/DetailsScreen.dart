import 'package:consultant_app/model/mail/MailData.dart';
import 'package:consultant_app/model/status/StatusMail.dart';
import 'package:consultant_app/view/tag/TagScreen.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/Constants.dart';
import '../status/StatusScreen.dart';
import '../status/StatusVM.dart';
import '../tiles/ActivityTile.dart';
import '../tiles/ImageTile.dart';
import '../widgets/BorderShape.dart';
import '../widgets/CustomText.dart';
import '../widgets/listView/TagHorizList.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MailData mailData = ModalRoute.of(context)!.settings.arguments as MailData;
    print('index detail $mailData');
    var yourValue = Provider.of<StatusVM>(context).getData();
    print('data from status: $yourValue');
    return Scaffold(
      backgroundColor: kLightWhiteColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(right: 16, left: 16),
              height: 60,
              child: Row(
                children: [
                  const Image(image: AssetImage('images/arrow_left.png')),
                  const SizedBox(
                    width: 8,
                  ),
                  CustomText('Details', 18, 'Poppins', kLightPrimaryColor,
                      FontWeight.w600),
                  const Spacer(),
                  TextButton(
                      onPressed: () {},
                      child: CustomText('Update', 18, 'Poppins',
                          kLightPrimaryColor, FontWeight.w400))
                  // const Image(image: AssetImage('images/more.png')),
                ],
                //),
              ),
            ),
            _detailWidget(mailData),
          ],
        ),
      ),
    );
  }
}

// class DetailsScreen extends StatelessWidget {
//   const DetailsScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     MailData mailData = ModalRoute.of(context)!.settings.arguments as MailData;
//     print('index detail $mailData');
//     var yourValue = Provider.of<StatusVM>(context).getData();
//     print('data from status: $yourValue');
//     return Scaffold(
//       backgroundColor: kLightWhiteColor,
//       body: SafeArea(
//         child: Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.only(right: 16, left: 16),
//               height: 60,
//               child: Row(
//                 children: [
//                   const Image(image: AssetImage('images/arrow_left.png')),
//                   const SizedBox(
//                     width: 8,
//                   ),
//                   CustomText('Details', 18, 'Poppins', kLightPrimaryColor,
//                       FontWeight.w600),
//                   const Spacer(),
//                   const Image(image: AssetImage('images/more.png')),
//                 ],
//                 //),
//               ),
//             ),
//             _detailWidget(mailData),
//           ],
//         ),
//       ),
//     );
//   }
// }

class _detailWidget extends StatefulWidget {
  MailData data;

  _detailWidget(
    this.data, {
    super.key,
  });

  @override
  State<_detailWidget> createState() => _detailWidgetState();
}

class _detailWidgetState extends State<_detailWidget> {
  StatusMail? statusData;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16, top: 16),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(children: [
            BorderShape(
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16, bottom: 14),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(22))),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Image(
                              image: AssetImage('images/user.png'),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 18,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      // crossAxisAlignment:
                                      //     CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                            widget.data!.sender!.name!,
                                            16,
                                            'Poppins',
                                            kBlackColor,
                                            FontWeight.w600),
                                        const Spacer(),
                                        CustomText(
                                            getDate(widget.data.createdAt!),
                                            12,
                                            'Poppins',
                                            kHintGreyColor,
                                            FontWeight.w600),
                                      ],
                                    ),
                                    Row(
                                      // crossAxisAlignment:
                                      //     CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                            widget.data.sender!.category!.name!,
                                            12,
                                            'Poppins',
                                            kHintGreyColor,
                                            FontWeight.w400),
                                        const Spacer(),
                                        CustomText(
                                            getArchDate(
                                                widget.data.archiveDate!),
                                            12,
                                            'Poppins',
                                            kHintGreyColor,
                                            FontWeight.w400),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: kDividerColor,
                          thickness: 0.5,
                        ),
                        ExpandablePanel(
                          theme: const ExpandableThemeData(
                              iconColor: kLightPrimaryColor,
                              headerAlignment:
                                  ExpandablePanelHeaderAlignment.center),
                          header: CustomText(widget.data.subject!, 20,
                              'Poppins', kBlackColor, FontWeight.w600),
                          collapsed: Text(
                            widget.data.description == null
                                ? ''
                                : widget.data.description!,
                            softWrap: false,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                          ),
                          expanded: Text(
                            widget.data.description == null
                                ? ''
                                : widget.data.description!,
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Colors.white),
            const SizedBox(
              height: 12,
            ),
            //tags
            GestureDetector(
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TagScreen(),
                  ),
                )
              },
              child: BorderShape(
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 18, top: 14, bottom: 14, left: 17),
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomText('#', 20, 'Poppins', kDarkGreyColor2,
                              FontWeight.w600),
                          const SizedBox(
                            width: 12,
                          ),
                          TagHorizList(widget.data.tags!),
                          const Spacer(),
                          const Image(
                              image: AssetImage('images/arrow_right.png'))
                        ],
                      ),
                    ),
                  ),
                  Colors.white),
            ),
            const SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () => {
                _awaitReturnValueFromSecondScreen(context),
              },
              child: BorderShape(
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 17, top: 12, bottom: 12),
                    child: Row(
                      children: [
                        const Image(image: AssetImage('images/status.png')),
                        const SizedBox(
                          width: 12,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(int.parse(statusData != null
                                ? statusData!.color!
                                : widget.data.status!.color!)),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(22),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 5, bottom: 5, left: 13, right: 13),
                            child: CustomText(
                                statusData != null
                                    ? statusData!.name!
                                    : widget.data.status!.name!,
                                16,
                                'Poppins',
                                kBlackColor,
                                FontWeight.w600),
                          ),
                        ),
                        Spacer(),
                        const Image(
                            image: AssetImage('images/arrow_right.png')),
                      ],
                    ),
                  ),
                  Colors.white),
            ),
            //   }),
            //),
            const SizedBox(
              height: 12,
            ),
            Visibility(
              visible: widget.data.decision == null ? false : true,
              child: BorderShape(
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
                      left: 16,
                      right: 16,
                      bottom: 14,
                    ),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText('Decision', 18, 'Poppins', kBlackColor,
                            FontWeight.w600),
                        CustomText(widget.data.decision ?? '', 14, 'Poppins',
                            kBlackColor, FontWeight.w400),
                      ],
                    ),
                  ),
                  Colors.white),
            ),
            const SizedBox(
              height: 16,
            ),
            BorderShape(
                Padding(
                  padding: const EdgeInsets.only(
                      left: 19, right: 14, top: 20, bottom: 23),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText('Add Image', 16, 'Poppins', kLightPrimaryColor,
                          FontWeight.w400),
                      SizedBox(
                        height: 20,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        itemCount: 2,
                        itemBuilder: (BuildContext context, int idx) {
                          return ImageTile();
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 24,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Colors.white),
            Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                title: CustomText(
                    'Activity', 20, 'Poppins', kBlackColor, FontWeight.w600),
                backgroundColor: Colors.transparent,
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: widget.data.activities!.length,
                    itemBuilder: (context, index) {
                      return ActivityTile(widget.data.activities![index]);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 7,
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            BorderShape(
                Padding(
                  padding: const EdgeInsets.only(
                      right: 13, top: 8, bottom: 8, left: 16),
                  child: Row(
                    children: const [
                      CircleAvatar(
                        radius: 12.0,
                        backgroundImage: AssetImage('images/profile.png'),
                        backgroundColor: Colors.transparent,
                      ),
                      SizedBox(
                        width: 9,
                      ),
                      Expanded(
                        flex: 1,
                        child: TextField(
                          // style: Theme.of(context).textTheme.bodySmall,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Add new Activity …',
                            hintStyle: TextStyle(
                                color: kLightBlackColor,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      Image(image: AssetImage('images/send.png')),
                    ],
                  ),
                ),
                kLightGreyColor2),
            const SizedBox(
              height: 16,
            )
          ]),
        ),
        //      ],
        //  ),
      ),
    );
  }

  _awaitReturnValueFromSecondScreen(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StatusScreen(),
        ));
    // after the SecondScreen result comes back update the Text widget with it
    setState(() {
      statusData = result;
      print('status data $statusData');
    });
  }
}
