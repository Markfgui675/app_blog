import 'package:app_blog/Model/repository/authentication.dart';
import 'package:app_blog/View/conta/conta_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogOutRepository implements SignOut{
  @override
  sair(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => ContaPage()),
      (route) => false
    );
  }

}