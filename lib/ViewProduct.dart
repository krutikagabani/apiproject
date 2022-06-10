import 'dart:convert';

import 'package:apiproject/UpdateProduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ViewProduct extends StatefulWidget {
  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  Future<List> alldata;

  Future<List> getdata() async {
    Uri url = Uri.parse("http://picsyapps.com/studentapi/getProducts.php");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = response.body.toString();
      var json = jsonDecode(body);
      return json["data"];
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      alldata = getdata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Product"),
      ),
      body: FutureBuilder(
          future: alldata,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length <= 0) {
                return Center(child: Text("No Data Found"));
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {

                      return Container(
                        color: Colors.black12,
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      snapshot.data[index]["pname"].toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      snapshot.data[index]["qty"].toString(),
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "RS."+
                                      snapshot.data[index]["price"].toString(),
                                      style: TextStyle(fontSize: 18,color: Color(0xFF424242),),
                                    ),
                                    Text(
                                      snapshot.data[index]["department"]
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xFF616161),
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.all(10),
                               child:  Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Container(
                                     width: MediaQuery.of(context).size.width/2.5,
                                     child:ElevatedButton(
                                       onPressed: ()async{
                                         var pid = snapshot.data[index]["pid"].toString();

                                             Uri url =  Uri.parse("http://picsyapps.com/studentapi/deleteProductNormal.php");
                                             var response = await http.post(url,body:
                                             {
                                               "pid":pid,
                                             }
                                             );
                                             if(response.statusCode==200)
                                             {
                                               var body = response.body.toString();
                                               var json = jsonDecode(body);
                                               var message=json["message"].toString();
                                               Fluttertoast.showToast(
                                                   msg: message,
                                                   toastLength: Toast.LENGTH_SHORT,
                                                   gravity: ToastGravity.CENTER,
                                                   timeInSecForIosWeb: 1,
                                                   backgroundColor: Colors.black,
                                                   textColor: Colors.white,
                                                   fontSize: 15.0
                                               );
                                               setState(() {
                                                 alldata = getdata();
                                               });
                                             }
                                             else
                                             {
                                               print("API Error");
                                             }
                                           },
                                       child: Text("Delete"),
                                     ),
                                   ),
                                   Container(
                                     width: MediaQuery.of(context).size.width/2.5,
                                     child:ElevatedButton(
                                       onPressed: ()async {
                                         var pid = snapshot.data[index]["pid"].toString();

                                         Navigator.of(context).push(
                                           MaterialPageRoute(builder: (context) => UpdateProduct(updateid: pid,))
                                         );
                                       },
                                       child: Text("Update"),
                                     ),
                                   ),
                                 ],
                               ),
                              )
                            ],
                          ),
                        ),

                        // title: Text(snapshot.data[index]["ename"].toString()),
                        // subtitle:  Text(snapshot.data[index]["department"].toString()),
                        // trailing:  Text("Rs."+snapshot.data[index]["salary"].toString()),
                      );

                    });
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
