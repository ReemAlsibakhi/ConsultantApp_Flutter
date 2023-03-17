import 'package:consultant_app/repositories/Admin/Tag/tag_api.dart';
import 'package:flutter/material.dart';

class TagScreen extends StatefulWidget {
  const TagScreen({Key? key}) : super(key: key);

  @override
  State<TagScreen> createState() => _TagScreenState();
}

class _TagScreenState extends State<TagScreen> {
  TagApi tag = TagApi();
  int? selectedIndex;
  bool isSelected = false;
  late String? tagName="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All tags'),
        actions: [TextButton(
            onPressed:  ()async{
               Navigator.pop(context,tagName);},
            child: Text("Done",style:TextStyle (color:Colors.white),))],
      ),
      body: Scaffold(
        body: FutureBuilder(
            future: tag.getAllTags(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);
                Map<String, dynamic> tags =
                    snapshot.data as Map<String, dynamic>;
                print(tags);
                List<dynamic> tagsData = tags["tags"];
                print(" from snapshot ${tags["tags"]}");
                return ListView.builder(
                    itemCount: tagsData.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                              isSelected = true;
                              print("name tap tap tag razan  :${tagsData[index]["name"]}");
                              tagName = tagsData[index]["name"];
                            });
                          },
                          leading: Icon(
                            Icons.tag,
                            color: Colors.blue,
                          ),
                          title: Text("name :${tagsData[index]["name"]}"),

                          //subtitle: Text("email ${usersData[index]["email"]}"),
                          trailing: Wrap(children: [
                            Visibility(
                                visible: isSelected,
                                child: selectedIndex == index
                                    ? Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      )
                                    : Icon(Icons.close)),
                            TextButton(
                              child: Text('id'),
                              onPressed: () async {
                                var tagId = tagsData[index]["id"];
                                var tagName = tagsData[index]["name"];
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Tag details"),
                                        content: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          height: 200,
                                          child: ListTile(
                                              leading: Icon(Icons.tag),
                                              title: Text("Tag id : $tagId"),
                                              subtitle:
                                                  Text("Tag Name $tagName")),
                                        ),
                                      );
                                    });

                                // add delete function here
                              },
                            ),
                          ]));
                    });
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
