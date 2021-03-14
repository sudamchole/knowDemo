import 'package:drevolapp/model/employeeModel.dart';
import 'package:flutter/material.dart';

class EmpDetails extends StatefulWidget {
  final EmployeeModel index;
  EmpDetails({@required this.index});
 /* var id,fName,lName,email,contactNumber,age,dob,salary,address;
  EmpDetails({this.id,this.fName,this.lName,this.email,this.contactNumber,this.age,this.salary,this.address});
*/
  @override
  _EmpDetailsState createState() => _EmpDetailsState();
}

class _EmpDetailsState extends State<EmpDetails> {
  final appTitle = 'Employee Details';
  final List<EmployeeModel> _itemsDetails=[];

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
          body: Container(
            alignment: Alignment.centerLeft,
            width: MediaQuery.of(context).size.width,
            height: 290,
            margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black26),
              borderRadius: BorderRadius.all(Radius.circular(30))
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
              radius: 30.0,
              backgroundImage:NetworkImage(widget.index.imageUrl),
                backgroundColor: Colors.transparent,),
                const SizedBox(height: 15,),

                Text(widget.index.firstName+" "+widget.index.lastName,style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color: Colors.black),),
                SizedBox(height: 5,),
                Text(widget.index.email,style: TextStyle(fontSize: 15,color: Colors.black54),),
                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("DOB: "+widget.index.dob,style: TextStyle(fontSize: 15,color: Colors.black87),),
                    Text("Age: "+widget.index.age.toString(),style: TextStyle(fontSize: 15,color: Colors.black87),),

                  ],
                ),
                const SizedBox(height: 10,),
                Container(alignment:Alignment.centerLeft,child: Text("Contact No: "+widget.index.contactNumber,style: TextStyle(fontSize: 15,color: Colors.black87))),
                const  SizedBox(height: 10,),
                Container(alignment:Alignment.centerLeft,child: Text("Salary: "+widget.index.salary.toString(),style: TextStyle(fontSize: 15,color: Colors.black87),)),
                const SizedBox(height: 10,),
                Container(alignment:Alignment.centerLeft,child: Text("Address: "+widget.index.address,style: TextStyle(fontSize: 15,color: Colors.black87),)),
              ],

            ),
          ),
        ));
  }
}
