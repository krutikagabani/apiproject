import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddEmployee extends StatefulWidget {
  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  var operation = "F";
  var  value = "A";

  TextEditingController _ename = TextEditingController();
  TextEditingController _salary = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Employee"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Employee Name",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _ename,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Salary",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _salary,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Text(
                        "Gender : ",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Radio(
                          value: "F",
                          groupValue: operation,
                          onChanged: (val) {
                            setState(() {
                              operation = val;
                            });
                          }),
                      Text(
                        "Female",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Radio(
                          value: "M",
                          groupValue: operation,
                          onChanged: (val) {
                            setState(() {
                              operation = val;
                            });
                          }),
                      Text(
                        "Male",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        "Department : ",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      DropdownButton(
                          value: value,
                          onChanged: (val)
                          {
                            setState(() {
                              value = val;
                            });
                          },
                          items: [
                            DropdownMenuItem(
                              child: Text("Technical Department"),
                              value: "A",
                            ),
                            DropdownMenuItem(
                              child: Text("Sales Department"),
                              value: "B",
                            ),
                            DropdownMenuItem(
                              child: Text("Purchase Department"),
                              value: "C",
                            ),
                            DropdownMenuItem(
                              child: Text("Advertizement Department"),
                              value: "D",
                            ),
                            DropdownMenuItem(
                              child: Text("Testing Department"),
                              value: "E",
                            )
                          ],
                          hint: Text("Select item")),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        var name = _ename.text.toString();
                        var sal = _salary.text.toString();

                        Uri url = await Uri.parse(
                            "http://picsyapps.com/studentapi/insertEmployeeNormal.php");
                        var response = await http.post(url, body: {
                          "ename": name,
                          "salary": sal,
                          "gender": operation,
                          "department": value,
                        });
                        if (response.statusCode == 200)
                        {
                          var body = response.body.toString();
                          print("Body :" + body);
                        }
                        else
                        {
                          print("API Error");
                        }
                        //API
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(fontSize: 18),
                      ),
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
