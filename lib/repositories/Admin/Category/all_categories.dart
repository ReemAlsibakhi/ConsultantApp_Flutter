import 'package:flutter/material.dart';

import 'category_api.dart';
class AdminCatgeoryScreen extends StatefulWidget {
  const AdminCatgeoryScreen({Key? key}) : super(key: key);

  @override
  State<AdminCatgeoryScreen> createState() => _AdminCatgeoryScreenState();
}

class _AdminCatgeoryScreenState extends State<AdminCatgeoryScreen> {
  CatApi cat = CatApi();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('All Categories'),
      ),
      body: Scaffold(
        body: FutureBuilder(
            future: cat.getAllCategories(),
            builder:(context,snapshot){
              if(snapshot.hasData){
                print(snapshot.data);
                Map<String,dynamic> categories = snapshot.data as Map<String,dynamic>;
                print(categories);
                List<dynamic> categoriesData = categories["categories"];
                print(" from snapshot ${categories["categories"]}");
                return  ListView.builder(
                    itemCount: categoriesData.length,
                    itemBuilder: (context,index){
                      return ListTile(
                          leading: Icon(Icons.person,color: Colors.blue,),
                          title: Text("name :${categoriesData[index]["name"]}"),

                          //subtitle: Text("email ${usersData[index]["email"]}"),
                          trailing: Wrap(
                              children: [
                                TextButton(child:Text ('V'),onPressed: ()async {
                                  var userId = categoriesData[index]["id"];
                                  print(userId);
                                  var response= await cat.getSingleCategory(userId);
                                  if(mounted){
                                    print(response);
                                    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$response")));
                                    showDialog(context: context, builder: (BuildContext context){
                                      return AlertDialog(title: Text("Category Details"),
                                        content: Container(
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                                          height: 200,
                                          child: ListTile(
                                              leading: Icon(Icons.person),
                                              title:
                                              Text("Category id : ${response["category"][0]["id"]}"),
                                              subtitle:

                                              Text("Category Name ${response["category"][0]["name"]}")

                                          ),



                                        ),
                                      );



                                    });
                                  }

                                  // add delete function here
                                },),


                              ]));
                    });
              }
              else{
                return CircularProgressIndicator();
              }

            }

        ),
      ),
    );
  }
}
