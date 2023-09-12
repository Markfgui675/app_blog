// TODO: implementar arquivo mobx que recupera os artigos, usuários, tópicos e os aloca em uma lista que será pesquisada pela view



import 'package:app_blog/Model/models/TipoAcessoDataBase.dart';
import 'package:app_blog/Model/servicos/acessardados_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../Model/models/Artigo.dart';
part 'search_viewmodel.g.dart';

class SearchViewModel = SearchViewModelMobx with _$SearchViewModel;

abstract class SearchViewModelMobx with Store{

  final TipoAcessoDataBase _tipoAcesso = TipoAcessoDataBase();
  final AcessarDadosRepository _acessarDados = AcessarDadosRepository();

  @observable
  List<Artigo> _artigos = [];

  @observable
  List<String> _topicos = [];

  @computed
  List<Artigo> get artigos => _artigos;

  @computed
  List<String> get topicos => _topicos;

  @action
  recuperarDados(BuildContext context)async{
    _tipoAcesso.tipo = TipoAcesso.acessarArtigos;
    _artigos = await _acessarDados.acessarDados(_tipoAcesso, context);
  }

  @action
  recuperarTopicos(BuildContext context)async{
    _tipoAcesso.tipo = TipoAcesso.acessarTopicos;
    _topicos = await _acessarDados.acessarDados(_tipoAcesso, context);
  }

}
