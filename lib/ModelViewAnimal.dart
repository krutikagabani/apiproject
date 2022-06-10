import 'dart:convert';
import 'package:apiproject/AnimalDetails.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'models/Animals.dart';
import 'models/Products.dart';

class ModelViewAnimal extends StatefulWidget {
  @override
  State<ModelViewAnimal> createState() => ModelViewAnimalState();
}

class ModelViewAnimalState extends State<ModelViewAnimal> {
  List<Animals> alldata;

  getdata() async {
    Uri url = Uri.parse("https://zoo-animal-api.herokuapp.com/animals/rand/10");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = response.body.toString();
      var json = jsonDecode(body);
      setState(() {
        alldata = json.map<Animals>((obj) => Animals.fromJson(obj)).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getdata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Model View Animal"),
      ),

      body: (alldata != null)
          ? ListView.builder(
              itemCount: alldata.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap:  (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AnimalDetails(obj: alldata[index],))
                    );
                  },
                  child: Container(
                  child: Card(
                    color: Colors.blueGrey,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Image.network(
                            alldata[index].imageLink.toString(),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Name : "+alldata[index].name.toString(), style: TextStyle(fontSize: 18, color: Colors.white),),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Latin name : "+alldata[index].latinName.toString(), style: TextStyle(fontSize: 18, color: Colors.white),),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Animal Type : "+alldata[index].animalType.toString(), style: TextStyle(fontSize: 18, color: Colors.white),),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Habitats : "+alldata[index].habitat.toString(), style: TextStyle(fontSize: 18, color: Colors.white),),
                        ],
                      ),
                    ),
                  ),
                ),
                );
                // return ListTile(
                //  leading: Image.network(alldata[index].imageLink.toString(),
                //   ),
                //   title:  Text(),
                //   trailing:  Text(),
                // );
              },
            )
          : Center(child: CircularProgressIndicator()),

      // body: FutureBuilder(
      //     future: alldata,
      //     builder: (context, snapshot) {
      //       if (snapshot.hasData) {
      //         if (snapshot.data.length <= 0) {
      //           return Center(child: Text("No Data Found"));
      //         } else {
      //           return ListView.builder(
      //               itemCount: snapshot.data.length,
      //               itemBuilder: (context, index) {
      //                 return ListTile(
      //                   title: Text(snapshot.data[index]["pname"].toString()),
      //                   subtitle:  Text(snapshot.data[index]["qty"].toString()),
      //                   trailing:  Text("Rs."+snapshot.data[index]["price"].toString()),
      //
      //                   onTap: ()async {
      //                     var pid = snapshot.data[index]["pid"].toString();
      //
      //                     Uri url =  Uri.parse("http://picsyapps.com/studentapi/deleteProductNormal.php");
      //                     var response = await http.post(url,body:
      //                     {
      //                       "pid":pid,
      //                     }
      //                     );
      //                     if(response.statusCode==200)
      //                     {
      //                       var body = response.body.toString();
      //                       var json = jsonDecode(body);
      //                       var message=json["message"].toString();
      //                       Fluttertoast.showToast(
      //                           msg: message,
      //                           toastLength: Toast.LENGTH_SHORT,
      //                           gravity: ToastGravity.CENTER,
      //                           timeInSecForIosWeb: 1,
      //                           backgroundColor: Colors.black,
      //                           textColor: Colors.white,
      //                           fontSize: 15.0
      //                       );
      //                       setState(() {
      //                         getdata();
      //                       });
      //                     }
      //                     else
      //                     {
      //                       print("API Error");
      //                     }
      //                   },
      //                 );
      //               });
      //         }
      //       } else {
      //         return Center(child: CircularProgressIndicator());
      //       }
      //     }),
    );
  }
}
