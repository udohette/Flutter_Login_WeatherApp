

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/app_resources/string_resources.dart';
import 'package:flutter_weather_app/presentation/register.dart';
import 'package:flutter_weather_app/presentation/weather_page.dart';

import '../presentation/login.dart';

class  Routes{
  static const String initRoute = "/login";
  static const String registerRoute = "/register";
  static const String weatherRoute = "/weather";
}

class RoutesGenerator{

  static Route<dynamic> getRoutes(RouteSettings route){
    switch(route.name){
      case Routes.initRoute:
        return MaterialPageRoute(builder: (context)=> Login());

      case Routes.registerRoute:
        return MaterialPageRoute(builder: (context)=> Register());

        case Routes.weatherRoute:
    return MaterialPageRoute(builder: (context)=> Weather());

      default:
        return _defaultRoute();
    }
  }
  static Route<dynamic> _defaultRoute(){
    return MaterialPageRoute(builder: (context)=> Scaffold(
      appBar: AppBar(title: Text(AppString.default_route_title),
      ),
      body: Center(child: Text(AppString.default_route),),
    ));
  }
}