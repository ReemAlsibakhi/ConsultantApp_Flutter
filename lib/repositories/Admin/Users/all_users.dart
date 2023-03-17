import 'package:consultant_app/repositories/Admin/Users/user_api.dart';
import 'package:flutter/material.dart';

class AllUsers extends StatefulWidget {
  const AllUsers({Key? key}) : super(key: key);

  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  UserApi user = UserApi();
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    var response = user.getAllUsers();
    print("response ffrom all users section$response");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Users'),
      ),
      body: Scaffold(
        body: FutureBuilder(
            future: user.getAllUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);
                Map<String, dynamic> users =
                    snapshot.data as Map<String, dynamic>;
                print(users);
                List<dynamic> usersData = users["users"];
                print(" from snapshot ${users["users"]}");
                return ListView.builder(
                    itemCount: usersData.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          leading: Icon(
                            Icons.person,
                            color: Colors.blue,
                          ),
                          title: Text("name :${usersData[index]["name"]}"),

                          //subtitle: Text("email ${usersData[index]["email"]}"),
                          trailing: Wrap(children: [
                            TextButton(
                              child: Text('V'),
                              onPressed: () async {
                                var userId = usersData[index]["id"];
                                print(userId);
                                var response = await user.getSingleUser(userId);
                                if (mounted) {
                                  print(response);
                                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$response")));
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("User Details"),
                                          content: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            height: 200,
                                            child: ListTile(
                                                leading: Icon(Icons.person),
                                                title: Text(
                                                    "User name : ${response["user"][0]["name"]}"),
                                                subtitle: Text(
                                                    "User Email ${response["user"][0]["email"]}")),
                                          ),
                                        );
                                      });
                                }

                                // add delete function here
                              },
                            ),
                            TextButton(
                              child: Text('D'),
                              onPressed: () async {
                                var userId = usersData[index]["id"];
                                print(userId);
                                var response = await user.deleteUser(userId);
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("$response")));
                                }
                                setState(() {});
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
