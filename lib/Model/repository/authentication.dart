import 'package:app_blog/Model/repository/database.dart';
import 'package:flutter/cupertino.dart';
import '../models/Usuario.dart';

abstract class AuthenticationRepository{
  authentication(Usuario usuario, BuildContext context);
}

abstract class SignOut{
  sair(BuildContext context);
}
