import 'package:consultant_app/repositories/Admin/Category/category_api.dart';
import 'package:flutter/material.dart';

import '../../repositories/Inbox/Sender.dart';
import '../tag/TagScreen.dart';

class CategoriyScreen extends StatefulWidget {
  const CategoriyScreen({Key? key}) : super(key: key);

  @override
  State<CategoriyScreen> createState() => _CategoriyScreenState();
}

class _CategoriyScreenState extends State<CategoriyScreen> {
  CatApi capi = CatApi();
  int? selectedIndex; // selected index in the category list view.
  String category = ""; // category name to view in the new inbox screen.
  int cat_id = 4; // category id to send with new added inbox request.
  late Sender senderData = Sender(cat_id,
      category); // Object from sender to pass it's values to the new inbox screen.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF7F6FF),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  kTextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      text: 'Cancel'),
                  const Text(
                    'Category',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                  kTextButton(
                      text: 'Done',
                      onPressed: () {
                        Navigator.pop(context, senderData);
                      })
                ],
              ),
              SizedBox(
                height: 80,
              ),
              Container(
                  key: UniqueKey(),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25)),
                  height: 800,
                  width: double.infinity,
                  child: FutureBuilder(
                      future: capi.getAllCategories(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print(snapshot.data);
                          Map<String, dynamic> results =
                              snapshot.data as Map<String, dynamic>;
                          List<dynamic> resultsData = results["categories"];
                          print(
                              "results from th catgory screen page $resultsData");
                          print(resultsData.length);
                          return ListView.builder(
                              itemBuilder: (context, index) {
                                return TextButton(
                                  onPressed: () {
                                    category = resultsData[index]["name"];
                                    cat_id = resultsData[index]["id"];
                                    print("${resultsData[index]["id"]}");
                                  },
                                  child: ListTile(
                                      title:
                                          Text("${resultsData[index]["name"]}"),
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = index;
                                          category = resultsData[index]["name"];
                                        });
                                      },
                                      trailing: selectedIndex == index
                                          ? Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            )
                                          : null),
                                );
                              },
                              itemCount: resultsData.length);
                        } else {
                          return Container(child: CircularProgressIndicator());
                        }
                      })),
            ]),
          ),
        ),
      ),
    );
  }
}
