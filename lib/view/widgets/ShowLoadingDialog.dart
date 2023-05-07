import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => LoadingDialog(),
  );
}

class LoadingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: CupertinoActivityIndicator(),
        ),
      ),
    );
  }
}

// void showLoadingDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (context) => Center(
//       child: Container(
//         width: 100.0,
//         height: 100.0,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(4.0),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: CupertinoActivityIndicator(),
//         ),
//       ),
//     ),
//   );
// }
