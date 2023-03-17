import 'package:flutter/material.dart';

import '../../model/mail/Tags.dart';
import '../../utils/Constants.dart';
import '../widgets/CustomText.dart';

class TagTile extends StatelessWidget {
  final Tags tag;
  final List<Tags> tagList;
  // final Function onTap;
  TagTile(this.tag, this.tagList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.of(context).pushNamed('/MailByTag', arguments: {
          'tag': tag,
          'tagList': tagList,
        }),
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8, right: 8),
        padding: const EdgeInsets.only(top: 6, bottom: 6, right: 12, left: 12),
        decoration: const BoxDecoration(
            color: kLightGreyColor,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Center(
          child: CustomText(
              '# ${tag.name}', 14, 'Poppins', kDarkGreyColor, FontWeight.w600),
        ),
      ),
    );
  }
}
// class TagTile extends StatefulWidget {
//   List<int> _selectedItems = [];
//   final Tags tag;
//   final List<Tags> tagList;
//   int index;
//   String from;
//   TagTile(this.tag, this.tagList, this.index, this.from, {Key? key})
//       : super(key: key);
//
//   @override
//   _MyGridViewState createState() => _MyGridViewState();
// }

// class _MyGridViewState extends State<TagTile> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         if (widget.from == 'from_home') {
//           print('froom ${widget.from}');
//           Navigator.of(context).pushNamed('/MailByTag', arguments: {
//             'tag': widget.tag,
//             'tagList': widget.tagList,
//           });
//         }
//         // if (viewModel.getSelectedItem().contains(widget.index)) {
//         //   viewModel.deleteItem(widget.index);
//         // } else {
//         //   viewModel.addItem(widget.index);
//         //   print('reem reem');
//         // }
//         // viewModel.getMailsByTag();
//
//         setState(() {
//           if (widget._selectedItems.contains(widget.index)) {
//             widget._selectedItems.remove(widget.index);
//           } else {
//             widget._selectedItems.add(widget.index);
//           }
//         });
//       },
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 8, right: 8),
//         padding: const EdgeInsets.only(top: 6, bottom: 6, right: 12, left: 12),
//         // color: viewModel.getSelectedItem().contains(widget.index)
//         //     ? kLightPrimaryColor
//         //     : kLightGreyColor,
//
//         color: widget._selectedItems.contains(widget.index)
//             ? kLightPrimaryColor
//             : kLightGreyColor,
//         // child: Center(
//         child: CustomText('# ${widget.tag.name}', 14, 'Poppins', kDarkGreyColor,
//             FontWeight.w600),
//         // ),
//       ),
//     );
//   }
// }
