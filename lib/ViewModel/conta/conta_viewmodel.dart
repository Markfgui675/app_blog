import 'package:app_blog/Model/models/TipoAcessoDataBase.dart';
import 'package:app_blog/Model/models/TipoSalvarDataBase.dart';
import 'package:app_blog/Model/servicos/acessardados_service.dart';
import 'package:app_blog/Model/servicos/salvardados_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import '../../Model/models/Artigo.dart';
import '../../Model/models/Usuario.dart';
part 'conta_viewmodel.g.dart';

class ContaViewModel = ContaViewModelMobx with _$ContaViewModel;

abstract class ContaViewModelMobx with Store{

  final AcessarDadosRepository _repositoryAcessar = AcessarDadosRepository();
  final SalvarDados _repositorySalvar = SalvarDados();
  final TipoAcessoDataBase _tipoAcesso = TipoAcessoDataBase();
  final TipoSalvarDataBase _tipoSalvar = TipoSalvarDataBase();
  final Usuario _usuario = Usuario();

  @observable
  List<Usuario> _infoUser = [];

  @observable
  List<Artigo> _artigos = [];

  @computed
  List<Usuario> get dadosUsuario{
    return _infoUser;
  }

  @computed
  List<Artigo> get artigosUsuario{
    return _artigos;
  }

  @action
  acessarDados(String tipo, BuildContext context) async {
    _tipoAcesso.tipo = tipo;
    _infoUser = await _repositoryAcessar.acessarDados(_tipoAcesso, context);
  }

  @action
  salvarDados(String tipo, BuildContext context, {String? nome, sobre, profilePic}) async {
    _tipoSalvar.tipo = tipo;
    _usuario.nome = nome!;
    _usuario.sobre = sobre!;
    _usuario.profilePic = profilePic!;
    _repositorySalvar.salvarDados(_tipoSalvar, context, args: _usuario);
    _tipoAcesso.tipo = TipoAcesso.acessarDadosUsuario;
    _infoUser = await _repositoryAcessar.acessarDados(_tipoAcesso, context);
  }

  @action
  acessarQuantidadeArtigos(String tipo, BuildContext context)async{
    _tipoAcesso.tipo = tipo;
    _artigos = await _repositoryAcessar.acessarDados(_tipoAcesso, context);
  }


}