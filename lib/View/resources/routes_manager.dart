import 'package:app_blog/View/home/home_page.dart';
import 'package:app_blog/View/leitura/leitura_page.dart';
import 'package:app_blog/View/resources/strings_manager.dart';
import 'package:flutter/material.dart';

class Routes{

  static const String initialRoute = '/';
  static const String leituraPage = 'leiturapage';

}

class RouteGenerator{

  static Route<dynamic> getRoute(RouteSettings routeSettings){

    dynamic args = routeSettings.arguments;

    switch(routeSettings.name){
      case Routes.initialRoute:
        return MaterialPageRoute(builder: (_) => HomePage());
      case Routes.leituraPage:
        return MaterialPageRoute(builder: (_) => LeituraPage(args));
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute(){
    return MaterialPageRoute(builder: (_){
      return Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.routeNotFound),
        ),
        body: const Center(
          child: Text(AppStrings.routeNotFound)
        ),
      );
    });
  }

}
