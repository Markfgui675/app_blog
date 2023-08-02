import 'package:app_blog/Model/data/collections_names.dart';
import 'package:app_blog/Model/repository/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../View/resources/routes_manager.dart';
import '../models/Usuario.dart';
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
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.initialRoute,
        (route) => false
      );
    }).catchError((error){
      // TODO: fazer tratamento de erros
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

class CreateUserWithEmailAndPassword implements AuthenticationRepository{
  @override
  authentication(Usuario usuario, BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signInWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha
    ).then((value){
      Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.initialRoute,
              (route) => false
      );
    }).catchError((error){
      // TODO: fazer tratamento de erros
      print(error.toString());
    });
  }

}
