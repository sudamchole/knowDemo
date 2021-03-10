import 'package:drevolapp/animation/FadeRoute.dart';
import 'package:drevolapp/animation/ScaleRoute.dart';
import 'package:drevolapp/screens/home.dart';
import 'package:drevolapp/screens/login.dart';
import 'package:drevolapp/screens/splash.dart';
import 'package:flutter/material.dart';

/// App Routes Class -> Routing class
class AppRoutes{

  //--------------------------------------------------------------- Constants ------------------------------------------------------------------------
  static const String APP_ROUTE_LOGIN = "/login";
  static const String APP_ROUTE_HOME = "/home";



  //--------------------------------------------------------------- Methods --------------------------------------------------------------------------

  /// Get Routes Method -> Route
  /// @param -> routeSettings -> RouteSettings
  /// @usage -> Returns route based on requested route settings

  Route getRoutes(RouteSettings routeSettings){

    switch(routeSettings.name){
      case APP_ROUTE_LOGIN:{
        return FadeRoute(page:Login());

      }

      case APP_ROUTE_HOME: {
        return FadeRoute(page: Home());

      }
      default: {
        return ScaleRoute(page:Splash());

      }
    }
  }

}
