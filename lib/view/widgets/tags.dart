import 'package:consultant_app/model/tags/tags_model.dart';
import 'package:consultant_app/view/widgets/tagswidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../tag/TagVM.dart';

class ListOfTags extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myProvider = Provider.of<ProviderTags>(context);
    myProvider.getTags();
    List<Tag> tags = myProvider.temp;
    print(tags);
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(25)),
      height: 150,
      width: double.infinity,
      child: Wrap(
          spacing: 8.0, // space between tags
          runSpacing: 4.0, // space between rows of tags
          children: tags.map((tag) => tagsWidget(label: tag.name)).toList()),
    );
  }
}
