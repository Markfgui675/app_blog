import 'package:app_blog/Model/models/TipoSalvarDataBase.dart';
import 'package:app_blog/View/common/gerador_id.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../../Model/models/Artigo.dart';
import '../../Model/repository/database.dart';

class ArtigoViewModel{

  late DataBase _dataBase;
  final Artigo _artigo = Artigo();
  final TipoSalvarDataBase _tipoSalvar = TipoSalvarDataBase();
  ArtigoViewModel(DataBase dataBase){
    _dataBase = dataBase;
  }

  salvarDados(String tipo, BuildContext context, {required String nomeAutor, required Artigo artigo}){
    FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    _tipoSalvar.tipo = tipo;
    _artigo.id = GeradorId.gerarId();
    _artigo.idAutor = user!.uid;
    _artigo.titulo = artigo.titulo;
    _artigo.subTitulo = artigo.subTitulo;
    _artigo.texto = artigo.texto;
    _artigo.autor = artigo.autor;
    _artigo.img = artigo.img;
    _artigo.topico = artigo.topico;
    _dataBase.salvarDados(_tipoSalvar, context, args: _artigo);
  }

}
