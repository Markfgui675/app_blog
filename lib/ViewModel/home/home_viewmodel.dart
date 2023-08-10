import 'package:app_blog/Model/repository/acessardados.dart';
import 'package:flutter/cupertino.dart';
import '../../Model/models/Frase.dart';
import '../../Model/models/TipoAcessoDataBase.dart';

class HomeViewModel{

  late AcessarDados _repository;
  final TipoAcessoDataBase _tipoAcesso = TipoAcessoDataBase();
  Frase _frase = Frase();
  HomeViewModel(AcessarDados repository){
    _repository = repository;
  }

  sortearFrase(String tipoAcesso, BuildContext context)async{
    _tipoAcesso.tipo = tipoAcesso;
    _frase = await _repository.acessarDados(_tipoAcesso, context);
    print('Frase aqui na viewmodel: '+_frase.frase);
  }

}
