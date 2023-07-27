import 'package:app_blog/Model/repository/authentication.dart';
import 'package:flutter/cupertino.dart';
import '../../Model/models/Usuario.dart';
import '../../Model/repository/database.dart';

class LoginViewModel{

  late AuthenticationRepository _repository;
  LoginViewModel(AuthenticationRepository repository){
    _repository = repository;
  }

  criarConta(Usuario usuario, BuildContext context){
    _repository.authentication(usuario, context);
  }

  entrar(Usuario usuario, BuildContext context){
    _repository.authentication(usuario, context);
  }

}