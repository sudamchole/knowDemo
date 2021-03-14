import 'package:drevolapp/model/employeeModel.dart';
import 'package:flutter/material.dart';

class EmpDetails extends StatefulWidget {
  var id,fName,lName,email,contactNumber,age,dob,salary,address;
  EmpDetails({this.id,this.fName,this.lName,this.email,this.contactNumber,this.age,this.salary,this.address});

  @override
  _EmpDetailsState createState() => _EmpDetailsState();
}

class _EmpDetailsState extends State<EmpDetails> {
  final appTitle = 'Employee Details';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: appTitle,
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(appTitle),
          ),
          body: Column(
            children: <Widget>[
              Text(widget.fName),
              Text(widget.lName),
              Text(widget.address),
              Text(widget.age),
              Text(widget.salary),
              Text(widget.dob),
              Text(widget.address),
            ],

          ),
        ));
  }
}
