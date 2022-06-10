import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'models/Products.dart';

class ModelViewProduct extends StatefulWidget {

  @override
  State<ModelViewProduct> createState() => _ModelViewProductState();
}

class _ModelViewProductState extends State<ModelViewProduct> {

  List<Products> alldata;

  getdata() async {
    Uri url = Uri.parse("http://picsyapps.com/studentapi/getProducts.php");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = response.body.toString();
      var json = jsonDecode(body);
      setState(() {
        alldata = json["data"].map<Products>( (obj) => Products.fromJson(obj)).toList();
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
        title: Text("Model View Product"),
      ),

      body: (alldata!=null)?
          ListView.builder(
            itemCount: alldata.length,
            itemBuilder: (context,index)
            {
              return ListTile(
                leading: Text(alldata[index].pname.toString()),
                title: Text(alldata[index].qty.toString()),
                trailing: Text(alldata[index].price.toString()),
              );
            },
          )
          :Center(child: CircularProgressIndicator()),

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
