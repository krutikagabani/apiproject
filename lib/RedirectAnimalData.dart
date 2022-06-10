import 'package:flutter/material.dart';

class RedirectAnimalData extends StatefulWidget {

  var image = "";
  var name = "";
  var latinname = "";
  var animaltype = "";
  var habitat = "";

  RedirectAnimalData({this.image, this.name, this.latinname, this.animaltype, this.habitat});

  @override
  State<RedirectAnimalData> createState() => _RedirectAnimalDataState();
}

class _RedirectAnimalDataState extends State<RedirectAnimalData> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Show Animal Data"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height/1.7,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(widget.image.toString()),
                    fit: BoxFit.fill,
                  )
                ),
                child: Card(
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Divider(),
              Text(
                "Name :"+ widget.name,
                style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold,
                ),
              ),
              Divider(),
              Text(
                "Latin-Name :"+  widget.latinname,
                style: TextStyle(
                    fontSize: 20),
              ),
              Divider(),
              Text(
                "Animal Type :"+ widget.animaltype,
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF424242),
                ),
              ),
              Divider(),
              Text(
                "Habitat :"+ widget.habitat,
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
  }
}
