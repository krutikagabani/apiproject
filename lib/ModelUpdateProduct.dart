import 'dart:convert';

import 'package:apiproject/UpdateProduct.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'ViewProduct.dart';
import 'models/Products.dart';

class ModelUpdateProduct extends StatefulWidget {
  @override
  State<ModelUpdateProduct> createState() => _ModelUpdateProductState();
}

class _ModelUpdateProductState extends State<ModelUpdateProduct> {

  TextEditingController _name = TextEditingController();
  TextEditingController _qty = TextEditingController();
  TextEditingController _price = TextEditingController();

  List<UpdateProduct> alldata;

  getdata() async {
    Uri url = Uri.parse("http://picsyapps.com/studentapi/getProducts.php");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = response.body.toString();
      var json = jsonDecode(body);
      setState(() {
        // alldata = json["data"].map<UpdateProduct>( (obj) => UpdateProduct.fromJson(obj)).toList();
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
        title: Text("Model Update Product"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  Text("Product Name", style: TextStyle(fontSize: 18),),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: _name,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text("Quantity", style: TextStyle(fontSize: 18),),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: _qty,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text("Price", style: TextStyle(fontSize: 18),),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: _price,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 50,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: ()async{
                        var nm = _name.text.toString();
                        var qt = _qty.text.toString();
                        var pri = _price.text.toString();
                        //200 okay
                        //404 not found
                        //500 server down

                        _name.text="";
                        _qty.text="";
                        _price.text="";

                        //API
                        Uri url =  Uri.parse("http://picsyapps.com/studentapi/insertProductNormal.php");
                        var response = await http.post(url,body:
                        {
                          "pname":nm,
                          "qty":qt,
                          "price":pri,
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
                        }
                        else
                        {
                          print("API Error");
                        }

                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => ViewProduct())
                        );
                        //API
                      },
                      child: Text("Update", style: TextStyle(fontSize: 18),),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
}
