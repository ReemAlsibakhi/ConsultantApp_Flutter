import 'package:consultant_app/view/tag/TagVM.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/tags/tags_model.dart';
import '../widgets/AddTagFeild.dart';
import '../widgets/tags.dart';

class TagScreen extends StatefulWidget {
  const TagScreen({Key? key}) : super(key: key);
  @override
  State<TagScreen> createState() => _TagScreenState();
}

class _TagScreenState extends State<TagScreen> {
  final TextEditingController _controller = TextEditingController();
  late int clickedItem = 0;
  @override
  Widget build(BuildContext context) {
    final myProvider = Provider.of<ProviderTags>(context, listen: false);

    return Scaffold(
      backgroundColor: Color(0xffF7F6FF),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  kTextButton(
                      text: 'Cancel',
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  Text(
                    'Tags',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                  kTextButton(
                      text: 'Done',
                      onPressed: () {
                        myProvider.getSingleTag(clickedItem);
                        Navigator.pop(context);
                      })
                ],
              ),
              SizedBox(
                height: 40,
              ),
              ListOfTags(),
              SizedBox(
                height: 16,
              ),
              AddTags(
                onSubmitted: (String newTag) {
                  Tag tag = Tag(
                    id: '${myProvider.temp.length}',
                    name: newTag,
                    createdAt: DateTime.now().toString(),
                    updatedAt: DateTime.now().toString(),
                  );
                  myProvider.postSingleTag(tag);
                  _controller.clear();
                  print(tag.name);
                  print('done');
                },
                controller: _controller,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget kTextButton({required String text, required Function() onPressed}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
            color: Colors.blueAccent,
            fontSize: 18,
            fontWeight: FontWeight.normal),
      ),
    );
