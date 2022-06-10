import 'package:flutter/material.dart';

import 'models/Animals.dart';

class AnimalDetails extends StatefulWidget {


  Animals obj;
  AnimalDetails({this.obj});

  @override
  State<AnimalDetails> createState() => _AnimalDetailsState();
}

class _AnimalDetailsState extends State<AnimalDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animal Details"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Card(
            color: Colors.blueGrey,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Image.network(widget.obj.imageLink,),
                  Divider(),
                  Text("Name : "+widget.obj.name, style: TextStyle(fontSize: 18, color: Colors.white),),
                  Divider(),
                  Text("Latin name : "+widget.obj.latinName, style: TextStyle(fontSize: 18, color: Colors.white),),
                  Divider(),
                  Text("Animal Type : "+widget.obj.animalType, style: TextStyle(fontSize: 18, color: Colors.white),),
                  Divider(),
                  Text("Habitat : "+widget.obj.habitat, style: TextStyle(fontSize: 18, color: Colors.white),  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
