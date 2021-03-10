import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final appTitle = 'Home';

  List _items;

  List visitedList;
  List favList;
  List _searchListItems;
  var _searchEdit = new TextEditingController();

  bool _isSearch = true;
  String _searchText = "";

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/users.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["users"];
    });
  }

  @override
  initState() {
    super.initState();
    Timer.run(() {
      readJson();
    });
  }
  _HomeState() {
    _searchEdit.addListener(() {
      if (_searchEdit.text.isEmpty) {
        setState(() {
          _isSearch = true;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearch = false;
          _searchText = _searchEdit.text;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: appTitle,
        home: Scaffold(
          appBar: AppBar(
            title: Text(appTitle),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.exit_to_app), onPressed: ()  {
                showLogoutDialog(context);

              }),

            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    Flexible(child: _searchBox()),
                    Image(
                      image: AssetImage("assets/ic_sort.png"),
                      width: 30,
                      height: 30,

                    ),
                  ],
                ),
                // Display the data loaded from sample.json
                _isSearch ?Expanded(
                        child: ListView.builder(
                          itemCount: _items.length,
                          itemBuilder: (context, index) {
                            return _showUserListItem(index);
                          },
                        ),
                      ): _searchListView()

              ],
            ),
          ),
          drawer: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.

            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text('Drawer Header'),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
                ListTile(
                  title: Text('Item 1'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Item 2'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ));
  }
  Widget _showUserListItem(index){
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black87, width: 1.0)),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: Container(
        child: Row(
          children: <Widget>[
            showImageView(_items[index]["profile_pic"]),
            SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment:
              MainAxisAlignment.start,
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: <Widget>[
               _isSearch? Text("Name: " + _items[index]["username"]):Text("Name: " + _searchListItems[index]),
                Text(
                  "Email: " + _items[index]["email"]),
                Text("City: " + _items[index]["city"]),
                Text( _items[index]["contact_numbers"][0]["contact_type"]+": "+_items[index]["contact_numbers"][0]["contact_no"]),
                visitedButNotInFav(index),
                //getTextWidgets(_items)
              ],
            )
          ],
        ),
        //leading: Image.memory(_items[index]("profile_pic]")),
        // child: Text(_items[index]["username"]),
        //  subtitle: Text(_items[index]["email"]),
      ),
    );
  }
  Widget _searchBox() {
    return Container(
      decoration: BoxDecoration(border: Border.all(width: 1.0),borderRadius:BorderRadius.all(
        Radius.circular(15.0)), ),
      child:  new TextField(
          controller: _searchEdit,
          decoration: InputDecoration(
            hintText: "Search",
            hintStyle: new TextStyle(color: Colors.grey[300]),
          ),
          textAlign: TextAlign.center,

        ),

    );
  }
  showImageView(_base64){
    Uint8List bytes = base64.decode(_base64.toString().replaceAll("data:image/png;base64,", ""));
   return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(30.0)),
        color: Colors.transparent,
      ),
      child:Image.memory(bytes,width: 60,height: 60,)
    );
  }
  showLogoutDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Logout"),
          content: new Text('Are you sure you want to logout?'),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  child: new Text("Cancel"),
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                ),
                Container(width: 64),
                FlatButton(
                  child: new Text("Logout"),
                  onPressed: () async {
                    SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                    preferences.clear();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/login', (Route<dynamic> route) => false);
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
  visitedButNotInFav(index){

    favourate(index);

    List visit=new List();
    var strList="";
    visit.add(_items[index]["visited_products"]);
    print(visit);
    for (int j = 0; j < _items[index]["visited_products"].length; j++) {
      if(!favList.contains(_items[index]["visited_products"][j]["product_id"])){
        print(_items[index]["visited_products"][j]["product_id"]);
       if(j==_items[index]["visited_products"].length-1){
         strList+=_items[index]["visited_products"][j]["product_id"];
       } else{
         strList+=_items[index]["visited_products"][j]["product_id"]+",";
       }
      }


    }
    return Text("Product he may Like: "+strList);


  }

  favourate(index){
    favList=new List();
    var strList="";
    //print(favList);
    for (int j = 0; j < _items[index]["favourite_products"].length; j++) {



      favList.add(_items[index]["favourite_products"][j]["product_id"]);
      print(_items[index]["favourite_products"][j]["product_id"]);

      strList+=_items[index]["favourite_products"][j]["product_id"]+",";

    }
    return Text(strList);

  }
  Widget _searchListView() {
    _searchListItems = new List<String>();
    for (int i = 0; i < _items.length; i++) {
      var item = _items[i]["username"];



      if (item.toLowerCase().contains(_searchText.toLowerCase())) {
        _searchListItems.add(item);
      }
    }
    return _searchAddList();
  }
  Widget _searchAddList() {
    setState(() {

    });
    return new Flexible(
      child: new ListView.builder(
        itemCount: _searchListItems.length,
        itemBuilder: (BuildContext context, int index) {
          return _showUserListItem(index); /*new Card(
            color: Colors.cyan[100],
            elevation: 5.0,
            child: new Container(
              margin: EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  new Text("${_searchListItems[index]}"),

                ],
              ),
            ),
          );*/
        }),
    );
  }

}





