import 'package:flutter/material.dart';
class CategoryListTile extends StatefulWidget {


 CategoryListTile(
   this.category, {super.key}
     );
  bool isVisible = false;
  String category;
 // int? selectedCategoryIndex;

 @override
  State<CategoryListTile> createState() => _CategoryListTileState();
}

class _CategoryListTileState extends State<CategoryListTile> {


  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(widget.category),
      onTap: (){
        setState(() {
          widget.isVisible=!widget.isVisible;
        });

      },
      trailing: Visibility(visible: widget.isVisible, child: widget.isVisible?Icon(Icons.check,color: Colors.green,):SizedBox(),),);
  }
}
