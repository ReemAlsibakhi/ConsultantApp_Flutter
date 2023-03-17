import 'package:flutter/material.dart';

import '../../../view/widgets/Button.dart';
import '../../../view/widgets/customTextField.dart';
import 'category_api.dart';

class CreateCategory extends StatefulWidget {
  const CreateCategory({Key? key}) : super(key: key);

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  TextEditingController categoryNameController = TextEditingController();
  CatApi capi = CatApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Category'),
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xFF6589FF),
              Color(0xFFEAEAF5),
            ],
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  customTextField(
                    "Category Name",
                    false,
                    controller: categoryNameController,
                  ),
                  Button(
                    title: 'Create',
                    onPressed: () async {
                      var response = await capi
                          .createCategory(categoryNameController.text);

                      print(response);
                      if (response.toString().contains("message")) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Category Created Successfully"),
                          ));
                        }
                      } else {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("${response}"),
                          ));
                        }
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
