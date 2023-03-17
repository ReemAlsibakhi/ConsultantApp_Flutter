import 'package:flutter/material.dart';
class MyListTile extends StatelessWidget {
   MyListTile({Key? key,  this.title,this.leading,  this.trailing,  this.subTitle}) : super(key: key);
   Widget? title;
   Widget? leading;
   Widget? trailing;
   Widget? subTitle;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 0.5,
      leading: leading,
      title: title,
      trailing: trailing,
      subtitle: subTitle
    );
  }
}
