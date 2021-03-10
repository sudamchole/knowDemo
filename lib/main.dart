import 'package:flutter/material.dart';

import 'main/AppRoutes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  static final MyApp _instance = MyApp._internal();
  MyApp._internal();
  factory MyApp() => _instance;

  @override
  Widget build(BuildContext context) {
   /* SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);

    AutoOrientation.portraitAutoMode();*/

    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'SegoeUI',
        //brightness: Brightness.light,
        //primaryColor: Colors.blue[600],
        //accentColor: Colors.black,
        //primaryTextTheme: TextTheme(title: TextStyle(color: Colors.black))
      ),
      onGenerateRoute: getAppRoutes().getRoutes,
    );
  }

  AppRoutes getAppRoutes(){
    return AppRoutes();
  }
}
