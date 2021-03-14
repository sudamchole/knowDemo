import 'dart:async';
import 'dart:convert';
import 'package:drevolapp/model/employeeModel.dart';
import 'package:drevolapp/screens/empDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:toast/toast.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final appTitle = 'Home';

  List<EmployeeModel> _items;
  List<String> strList = [];

  // Fetch content from the json file
  EmployeeModel employeeModel;
 // static const _pageSize = 50;

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/employees.json');
    //  final data  = await json.decode(response);
    //assuming this json returns an array of signupresponse objects
    final List parsedList = json.decode(response);

    setState(() {
      _items = parsedList.map((val) => EmployeeModel.fromJson(val)).toList();

      print(_items.length);

      // add first 50 records
  /*    for (int i = 0; i < _pageSize; i++) {
        strList.add(_items[i].firstName);
      }*/
      for (int i = 0; i < _items.length; i++) {
        strList.add(_items[i].firstName);
      }
      _items.sort((a, b) =>
          a.firstName.toLowerCase().compareTo(b.firstName.toLowerCase()));
    });
  }

  @override
  initState() {
    super.initState();
    Timer.run(() {
      readJson();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: appTitle,
        home: Scaffold(
            appBar: AppBar(
              title: Text(appTitle),
            ),
            body: Padding(
                padding: const EdgeInsets.all(25),
                // Display the data loaded from sample.json
                child: _items != null
                    ? /*NotificationListener<ScrollNotification>(
                        // ignore: missing_return
                        onNotification: (
                          ScrollNotification scrollInfo) {
                          if (scrollInfo.metrics.pixels ==
                              scrollInfo.metrics.maxScrollExtent) {
                            loadMore();
                          }
                        },
                        child: AlphabetListScrollView(
                          strList: strList,
                          highlightTextStyle: TextStyle(
                            color: Colors.yellow,
                          ),
                          showPreview: true,
                          itemBuilder: (context, index) {
                            return (index == strList.length)
                                ? Container(
                                    color: Colors.greenAccent,
                                    // ignore: deprecated_member_use
                                    child: FlatButton(
                                      child: Text("Load More"),
                                      onPressed: () {
                                        loadMore();
                                      },
                                    ),
                                  )
                                : _list(index);
                          },
                          indexedHeight: (i) {
                            return 70;
                          },
                        ))*/
                AlphabetListScrollView(
                  strList: strList,
                  highlightTextStyle: TextStyle(
                    color: Colors.yellow,
                  ),
                  showPreview: true,
                  itemBuilder: (context, index) {
                    return _list(index);
                  },
                  indexedHeight: (i) {
                    return 70;
                  },
                ): Center(child: CircularProgressIndicator()))));
  }
// code for load 50 record at a time
 /* loadMore() {
    if(strList.length<_items.length-50){
      for (int i = 0; i < _pageSize + 50; i++) {
        strList.add(_items[i].firstName);
      }
      _items.sort((a, b) =>
        a.firstName.toLowerCase().compareTo(b.firstName.toLowerCase()));
    }else{
      Toast.show("No more items to load",context);
    }
  }*/

  Widget _list(index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EmpDetails(index:_items[index])),
        );
      },
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Text(
            _items[index].firstName[0] + _items[index].lastName[0],
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
        ),

        /* CircleAvatar(
          radius: 30.0,
          backgroundImage:
          NetworkImage(_items[index].imageUrl),
          backgroundColor: Colors.blueGrey,
        ),*/
        title: Text(_items[index].firstName),
        subtitle: Text(_items[index].lastName),
      ),
    );
  }
}
