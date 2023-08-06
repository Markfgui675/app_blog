import 'package:app_blog/Model/models/TipoAcessoDataBase.dart';
import 'package:app_blog/Model/servicos/acessardados_service.dart';
import 'package:mobx/mobx.dart';

import '../../Model/models/Usuario.dart';
part 'conta_viewmodel.g.dart';

class ContaViewModel = ContaViewModelMobx with _$ContaViewModel;

abstract class ContaViewModelMobx with Store{

  final AcessarDadosRepository _repository = AcessarDadosRepository();
  final TipoAcessoDataBase _tipo = TipoAcessoDataBase();

  @observable
  List<Usuario> _infoUser = [];

  @computed
  List<Usuario> get dadosUsuario{
    return _infoUser;
  }

  @action
  acessarDados(String tipo) async {
    _tipo.tipo = tipo;
    _infoUser = await _repository.acessarDados(_tipo);
    print(_infoUser);
  }

}