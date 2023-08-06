import 'package:app_blog/Model/data/collections_names.dart';
import 'package:app_blog/Model/models/TipoAcessoDataBase.dart';
import 'package:app_blog/View/common/mensagens.dart';
import 'package:app_blog/View/resources/strings_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../models/Usuario.dart';
import '../repository/acessardados.dart';

class AcessarDadosRepository implements AcessarDados{

  Mensagens _mensagens = Mensagens();

  @override
  acessarDados(TipoAcessoDataBase tipoAcesso, BuildContext context) {

    switch(tipoAcesso.tipo){

      case TipoAcesso.acessarDadosUsuario:
        return _acessarDadosUsuario(context);

    }

  }

  _acessarDadosUsuario(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore dbUsers = FirebaseFirestore.instance;
    User? user = await auth.currentUser;
    String _idUsuario = user!.uid;
    final docRef = await dbUsers.collection(CollectionsNames.usuarios).doc(_idUsuario);
    List<Usuario> _infoUser = [];
    try{
      await docRef.get().then((DocumentSnapshot doc){
        final dados = doc.data() as Map<String, dynamic>;
        _infoUser.clear();
        Usuario _usuario = Usuario();
        _usuario.nome = dados['nome'];
        _usuario.email = dados['email'];
        _usuario.profilePic = dados['profilePic'];
        _usuario.artigos = dados['artigos'];
        _usuario.seguindo = dados['seguindo'];
        _usuario.seguidores = dados['seguidores'];
        _infoUser.add(_usuario);
      });
      return _infoUser;
    } on FirebaseAuthException catch(e){
      if(e.code == 'network-request-failed'){
        _mensagens.mensagemError = ErrorStrings.semConexao;
      } else {
        _mensagens.mensagemError = e.toString();
      }
      _mensagens.state = false;
      return _mensagens.scaffoldMessege(context);
    }
  }

}