import 'package:app_blog/Model/models/TipoAcessoDataBase.dart';
import 'package:app_blog/Model/repository/acessardados.dart';
import 'package:app_blog/Model/servicos/logout_service.dart';
import 'package:flutter/cupertino.dart';
import '../../Model/models/Usuario.dart';

class ContaViewModel{

  late AcessarDados _acessarDados;
  TipoAcessoDataBase _tipo = TipoAcessoDataBase();
  Usuario _usuario = Usuario();
  LogOutRepository _logOut = LogOutRepository();
  List<dynamic> _dados = [];

  ContaViewModel(AcessarDados acessarDados){
    _acessarDados = acessarDados;
  }

  acessarDados(String tipoAcesso) async {
    _tipo.tipo = tipoAcesso;
    _dados.add(await _acessarDados.acessarDados(_tipo));
    print(_dados.toString());
    _usuario.nome = _dados[0][0].toString();
    _usuario.email = _dados[0][1].toString();
    _usuario.profilePic = _dados[0][2].toString();
    print('Resultado final: ${_usuario.nome}, ${_usuario.email}');
  }

  sair(BuildContext context){
    _logOut.sair(context);
  }

  dynamic get dados{
    return _usuario;
  }

}
