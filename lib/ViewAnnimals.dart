import 'dart:convert';

import 'package:apiproject/RedirectAnimalData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewAnnimals extends StatefulWidget {
  @override
  State<ViewAnnimals> createState() => _ViewAnnimalsState();
}

class _ViewAnnimalsState extends State<ViewAnnimals> {
  Future<List> alldata;

  Future<List> getdata() async {
    Uri url = Uri.parse("https://zoo-animal-api.herokuapp.com/animals/rand/10");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = response.body.toString();
      var json = jsonDecode(body);
      return json;
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
        title: Text("View Annimals"),
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
                      return GestureDetector(
                        onTap: ()async{
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => RedirectAnimalData(
                              image: snapshot.data[index]["image_link"].toString(),
                              name: snapshot.data[index]["name"].toString(),
                              latinname: snapshot.data[index]["latin_name"].toString(),
                              animaltype: snapshot.data[index]["latin_name"].toString(),
                              habitat: snapshot.data[index]["habitat"].toString(),
                            ))
                          );
                        },

                      child: Container(
                        child: Card(
                          color: Colors.transparent,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Image.network(
                                snapshot.data[index]["image_link"].toString(),
                              ),
                              SizedBox(height: 20,),
                              Text(
                                "Name :"+snapshot.data[index]["name"].toString(),
                                style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 20,),
                              Text(
                                "Latin-Name :"+ snapshot.data[index]["latin_name"].toString(),
                                style: TextStyle(
                                    fontSize: 20),
                              ),
                              SizedBox(height: 20,),
                              Text(
                                "Animal Type :"+snapshot.data[index]["animal_type"].toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFF424242),
                                ),
                              ),
                              SizedBox(height: 20,),
                              Text(
                                "Habitat :"+snapshot.data[index]["habitat"].toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFF424242),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
