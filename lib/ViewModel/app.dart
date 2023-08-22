import 'package:app_blog/View/resources/routes_manager.dart';
import 'package:app_blog/View/resources/theme_manager.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp._internal();

  static const MyApp instance = MyApp._internal();

  factory MyApp() => instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.initialRoute,
      theme: getApplicationTheme(),
    );
  }
}

