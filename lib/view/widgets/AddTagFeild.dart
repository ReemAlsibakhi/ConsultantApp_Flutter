


import 'package:flutter/material.dart';


class AddTags extends StatefulWidget {
  final Function( String newTag)onSubmitted;
  final TextEditingController controller;
  const AddTags({super.key, required this.onSubmitted, required this.controller});

  @override
  _AddTagsState createState() => _AddTagsState();
}

class _AddTagsState extends State<AddTags> {


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
     widget.controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:BoxDecoration(
          color:Colors.white,
        borderRadius:BorderRadius.circular(25.0)
      ),
      child: TextField(
         onSubmitted:widget.onSubmitted,
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: 'Add New Tags',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(25.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),

      ),
    );
  }
}
