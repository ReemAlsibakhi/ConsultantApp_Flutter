import 'package:consultant_app/repositories/Admin/Sender/sender_api.dart';
import 'package:flutter/material.dart';
import '../../../view/tag/TagScreen.dart';
import '../../Inbox/Sender.dart';
class SenderScreen extends StatefulWidget {
  const SenderScreen({Key? key}) : super(key: key);

  @override
  State<SenderScreen> createState() => _SenderScreenState();
}

class _SenderScreenState extends State<SenderScreen> {
  SenderApi sender = SenderApi();
   String category="";
   String senderName="";
   int id=1;
   int? selectedIndex;

  late Sender senderData = Sender(id,senderName,categoryName: category);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:Color(0xffF7F6FF),
      body:  SingleChildScrollView(
        child: SafeArea(child:
        Padding(
          padding:EdgeInsets.all(16),
          child: Column(
              children:[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    kTextButton(
                        onPressed: () {Navigator.pop(context);}, text: 'Cancel'
                    ),
                    Text('Senders',style:TextStyle(
                        color: Colors.black,
                        fontWeight:FontWeight.bold,
                        fontSize:24
                    ),),
                    kTextButton(text:'Done', onPressed: () {

                      //myProvider.getSingleStatus(clickedItem);
                      Navigator.pop(context,senderData);

                    })

                  ],
                ),
                // SizedBox(height:80,),
                Container(
                    key:UniqueKey(),
                    padding:EdgeInsets.all(8),
                    decoration:BoxDecoration(
                        color:Colors.white,
                        borderRadius:BorderRadius.circular(25)
                    ),
                    height:800,
                    width:double.infinity,
                    child: FutureBuilder(
                        future: sender.getAllSenders(),
                        builder: (context,snapshot){
                          if(snapshot.hasData){
                            print(snapshot.data);
                            Map<String,dynamic> results = snapshot.data as Map<String,dynamic>;
                            List<dynamic> resultsData = results["senders"];
                            print("Razan results from th senders screen page $resultsData");
                            print(resultsData.length);
                            return ListView.builder(itemBuilder: (context,index){
                              return TextButton(onPressed:(){
                                senderName=resultsData[index]["name"];
                                id = resultsData[index]["id"];
                                category=resultsData[index]["category"]["name"];
                                print("${resultsData[index]["id"]}");
                              },
                                child: ListTile(title: Text("${resultsData[index]["name"]}"),
                                    onTap: (){

                                      setState(() {
                                        selectedIndex=index;
                                        category=resultsData[index]["name"];
                                      });

                                    },
                                    trailing: selectedIndex==index ?Icon(Icons.check,color: Colors.green,):null),);
                            } , itemCount: resultsData.length);
                          }
                          else{
                            return CircularProgressIndicator();
                          }
                        }
                    )

                ),
              ]
          ),
        ),
        ),
      ),
    );
  }
}
