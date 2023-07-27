import 'package:app_blog/Model/models/TipoAcessoDataBase.dart';
import 'package:app_blog/Model/repository/acessardados.dart';
import 'package:flutter/foundation.dart';

class ContaViewModel with ChangeNotifier{

  late AcessarDados _acessarDados;
  TipoAcessoDataBase _tipo = TipoAcessoDataBase();
  dynamic _dados;

  ContaViewModel(AcessarDados acessarDados){
    _acessarDados = acessarDados;
  }

  Future acessarDados(String tipoAcesso) async {
    _tipo.tipo = tipoAcesso;
    _dados = await _acessarDados.acessarDados(_tipo);
    print('Return da funacao acessar dados: '+_dados.toString());
    notifyListeners();
  }

  dynamic get dados{
    return _dados;
}

}