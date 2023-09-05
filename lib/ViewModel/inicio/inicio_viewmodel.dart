import 'package:app_blog/Model/models/TipoAcessoDataBase.dart';
import 'package:app_blog/Model/servicos/acessardados_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import '../../Model/models/Artigo.dart';
part 'inicio_viewmodel.g.dart';

class InicioViewModel = InicioViewModelMobx with _$InicioViewModel;

abstract class InicioViewModelMobx with Store{

  final AcessarDadosRepository _repositoryAcessar = AcessarDadosRepository();
  final TipoAcessoDataBase _tipoAcesso = TipoAcessoDataBase();

  @observable
  List<Artigo> _populares = [];

  @observable
  List<Artigo> _emAlta = [];

  @computed
  List<Artigo> get artigosPopulares => _populares;

  @computed
  List<Artigo> get artigosEmAlta => _emAlta;

  @action
  recuperarArtigosPopulares(BuildContext context)async{
    List<Artigo> artigos = [];
    _tipoAcesso.tipo = TipoAcesso.acessarQuantidadeArtigos;
    artigos = await _repositoryAcessar.acessarDados(_tipoAcesso, context);
    print(artigos);
  }

  @action
  recuperarArtigosEmAlta(BuildContext context)async{
    List<Artigo> artigos = [];
    _tipoAcesso.tipo = TipoAcesso.acessarQuantidadeArtigos;
    artigos = await _repositoryAcessar.acessarDados(_tipoAcesso, context);
    print('em alta:');
    print(artigos);
  }

}
