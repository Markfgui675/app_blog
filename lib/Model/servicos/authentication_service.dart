import 'package:app_blog/Model/data/collections_names.dart';
import 'package:app_blog/Model/repository/database.dart';
import 'package:app_blog/View/common/mensagens.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../View/resources/routes_manager.dart';
import '../../View/resources/strings_manager.dart';
import '../models/Usuario.dart';
import '../repository/authentication.dart';

class CreateUserWithEmailAndPassword implements AuthenticationRepository, DataBase{

  @override
  authentication(Usuario usuario, BuildContext context) async {
    Mensagens _mensagem = Mensagens();
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try{
      await auth.createUserWithEmailAndPassword(
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
        _mensagem.mensagemOk = SuccessStrings.contaCriada;
        _mensagem.state = true;
        return _mensagem.scaffoldMessege(context);
      });
    } on FirebaseAuthException catch (e){
      if(e.code == 'network-request-failed'){
        _mensagem.mensagemError = ErrorStrings.semConexao;
      } else if(e.code == 'user-not-found'){
        _mensagem.mensagemError = ErrorStrings.usuarioNaoExiste;
      } else {
        _mensagem.mensagemError = ErrorStrings.naoLogin;
      }
      _mensagem.state = false;
      return _mensagem.scaffoldMessege(context);
    }
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
        'profilePic':'https://cdn-icons-png.flaticon.com/128/61/61205.png'
      }
    );
  }

}

class AuthUserWithEmailAndPassword implements AuthenticationRepository{
  @override
  authentication(Usuario usuario, BuildContext context) async {
    Mensagens _mensagem = Mensagens();
    FirebaseAuth auth = FirebaseAuth.instance;
    try{
      await auth.signInWithEmailAndPassword(
          email: usuario.email,
          password: usuario.senha
      ).then((value){
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.initialRoute,
          (route) => false
        );
        _mensagem.mensagemOk = SuccessStrings.login;
        _mensagem.state = true;
        return _mensagem.scaffoldMessege(context);
      });
    } on FirebaseAuthException catch(e){
      if(e.code == 'network-request-failed'){
        _mensagem.mensagemError = ErrorStrings.semConexao;
      } else if(e.code == 'user-not-found'){
        _mensagem.mensagemError = ErrorStrings.usuarioNaoExiste;
      } else {
        _mensagem.mensagemError = ErrorStrings.naoLogin;
      }
      _mensagem.state = false;
      return _mensagem.scaffoldMessege(context);
    }
  }

}
