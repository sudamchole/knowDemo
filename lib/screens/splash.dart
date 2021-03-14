import 'dart:async';

import 'package:drevolapp/main/AppRoutes.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashView(),
      onGenerateRoute: AppRoutes().getRoutes,
    );
  }
}

class SplashView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashState();

}

class SplashState extends State<SplashView>
  with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    startTimeout();

  }

  startTimeout() async {
    return Timer(const Duration(seconds: 3), navigateRoot);
  }

  void navigateRoot() async {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/home', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(left: 20,right: 20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/flutter_logo.png"), fit: BoxFit.contain),
        ),
      ),
    );
  }}
