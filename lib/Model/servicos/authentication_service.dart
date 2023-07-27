import 'package:app_blog/Model/data/collections_names.dart';
import 'package:app_blog/Model/models/Usuario.dart';
import 'package:app_blog/Model/repository/database.dart';
import 'package:app_blog/View/inicio/inicio_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../View/resources/routes_manager.dart';
import '../repository/authentication.dart';

class AuthEmailAndPasswordRepository implements AuthenticationRepository, DataBase{

  @override
  authentication(Usuario usuario, BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    auth.createUserWithEmailAndPassword(
      email: usuario.email, 
      password: usuario.senha
    ).then((firebaseUser){
      user = firebaseUser.user;
      Map<dynamic, dynamic> map = {
        'usuario':usuario,
        'user':user
      };
      salvarDados(map);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => InicioPage()),
        (route) => false
      );
    }).catchError((error){
      print(error.toString());
    });

  }

  @override
  void salvarDados(dynamic args) {
    FirebaseFirestore dbUsers = FirebaseFirestore.instance;
    User user = args['user'];
    Usuario usuario = args['usuario'];
    dbUsers.collection(CollectionsNames.usuarios).doc(user.uid).set(
      {
        'id':user.uid,
        'nome':usuario.nome,
        'email':usuario.email,
        'seguidores':[],
        'seguindo':[],
        'artigos':[],
        'profilePic':''
      }
    );
  }

}

class CreateUserWithEmailAndPassword implements AuthenticationRepository, DataBase{

  @override
  void authentication(Usuario usuario, BuildContext context) {

  }

  @override
  void salvarDados(dynamic args) {
    // TODO: implement salvarDados
  }

}
