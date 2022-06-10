import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'ViewProduct.dart';

class UpdateProduct extends StatefulWidget {

  var updateid="";
  UpdateProduct({this.updateid});

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {

  TextEditingController _name = TextEditingController();
  TextEditingController _qty = TextEditingController();
  TextEditingController _price = TextEditingController();

  getdata()async {
    Uri url = Uri.parse("http://picsyapps.com/studentapi/getSingleProduct.php");
    var response = await http.post(url, body: {"pid":widget.updateid});
    if(response.statusCode==200)
      {
        var body = response.body.toString();
        var json = jsonDecode(body);
        setState(() {
          _name.text = json["data"]["pname"].toString();
          _qty.text = json["data"]["qty"].toString();
          _price.text = json["data"]["price"].toString();
        });
      }
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  updatedata(){}

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    updatedata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update product"),
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: ElevatedButton(
                      onPressed: ()async{

                        var nm = _name.text.toString();
                        var qt = _qty.text.toString();
                        var pri = _price.text.toString();

                        var pid = widget.updateid.toString();

                        //200 okay
                        //404 not found
                        //500 server down

                        _name.text="";
                        _qty.text="";
                        _price.text="";


                        Uri url =  Uri.parse("http://picsyapps.com/studentapi/updateProductNormal.php");

                        var response = await http.post(url,body:
                        {
                          "pname":nm,
                          "qty":qt,
                          "price":pri,
                          "pid":pid,
                        }
                        );
                        if(response.statusCode==200)
                        {
                          var body = response.body.toString();
                          var json = jsonDecode(body);
                          var message=json["message"].toString();
                          Fluttertoast.showToast(
                              msg:message,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0
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
