import 'package:consultant_app/repositories/Admin/Status/status_api.dart';
import 'package:flutter/material.dart';

class RStatusScreen extends StatefulWidget {
  const RStatusScreen({Key? key}) : super(key: key);

  @override
  State<RStatusScreen> createState() => _RStatusScreenState();
}

class _RStatusScreenState extends State<RStatusScreen> {
  ApiStatus status = ApiStatus();
  late String? statusName;
  int? selectedIndex;
  bool isSelected=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Status'),
        actions: [TextButton(
            onPressed:  ()async{
              Navigator.pop(context,statusName);},
            child: Text("Done",style:TextStyle (color:Colors.white),))],
      ),
      body: Scaffold(
        body: FutureBuilder(
            future: status.getAllStatus(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);
                Map<String, dynamic> statuses =
                snapshot.data as Map<String, dynamic>;
                print(statuses);
                List<dynamic> statusesData = statuses["statuses"];
                print(" from snapshot ${statuses["statuses"]}");
                return ListView.builder(
                    itemCount: statusesData.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                              isSelected = true;
                              print("name tap tap tag razan  :${statusesData[index]["name"]}");
                              statusName = statusesData[index]["name"];
                            });
                          },
                          leading: Icon(
                            Icons.tag,
                            color: Colors.blue,
                          ),
                          title: Text("name :${statusesData[index]["name"]}"),

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
                                var tagId = statusesData[index]["id"];
                                var tagName = statusesData[index]["name"];
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Status details"),
                                        content: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(50)),
                                          height: 200,
                                          child: ListTile(
                                              leading: Icon(Icons.tag),
                                              title: Text("Status id : $tagId"),
                                              subtitle:
                                              Text("Status Name $tagName")),
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
