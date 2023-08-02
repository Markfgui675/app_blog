import 'package:app_blog/Model/repository/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../View/resources/routes_manager.dart';

class LogOutRepository implements SignOutRepository{
  @override
  sair(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signOut();
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.initialRoute,
      (route) => false
    );
  }
}