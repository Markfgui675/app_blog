import 'package:app_blog/View/resources/routes_manager.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  MyApp._internal();

  static final MyApp instance = MyApp._internal();

  factory MyApp() => instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.initialRoute,
    );
  }
}

