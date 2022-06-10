import 'package:apiproject/ModelUpdateProduct.dart';
import 'package:apiproject/ModelViewAnimal.dart';
import 'package:apiproject/ModelViewProduct.dart';
import 'package:apiproject/UpdateProduct.dart';
import 'package:apiproject/ViewEmployee.dart';
import 'package:flutter/material.dart';

import 'AddEmployee.dart';
import 'AddProduct.dart';
import 'ViewAnnimals.dart';
import 'ViewProduct.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: ModelUpdateProduct(),
    );
  }
}


