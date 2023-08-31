import 'package:app_blog/Model/data/collections_names.dart';
import 'package:app_blog/Model/models/TipoAcessoDataBase.dart';
import 'package:app_blog/View/common/mensagens.dart';
import 'package:app_blog/View/resources/strings_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../models/Artigo.dart';
import '../models/Frase.dart';
import '../models/Usuario.dart';
import '../repository/acessardados.dart';

class AcessarDadosRepository implements AcessarDados{

  @override
  acessarDados(TipoAcessoDataBase tipoAcesso, BuildContext context) {

    switch(tipoAcesso.tipo){
      case TipoAcesso.acessarDadosUsuario:
        return _acessarDadosUsuario(context);
      case TipoAcesso.acessarDadosFrases:
        return _acessarDadosFrases(context);
      case TipoAcesso.acessarQuantidadeArtigos:
        return _acessarQuantidadeArquivos(context);
      case TipoAcesso.acessarTopicos:
        return _acessarTopicos();
      default:
        return _error(context);
    }

  }

  _acessarDadosUsuario(BuildContext context) async {
    final Mensagens _mensagens = Mensagens();
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
        _usuario.sobre = dados['sobre'];
        _usuario.profilePic = dados['profilePic'];
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

  _acessarQuantidadeArquivos(BuildContext context)async{
    final Mensagens _mensagens = Mensagens();
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore dbUsers= FirebaseFirestore.instance;
    User? user = auth.currentUser;
    List<Artigo> artigos = [];
    try{
      await dbUsers.collection(CollectionsNames.artigos).where('idAutor', isEqualTo: user!.uid).get()
          .then((querySnapshot){
          for(var docSnapshot in querySnapshot.docs){
            Artigo _artigo = Artigo();
            _artigo.id = docSnapshot.data()['id'];
            _artigo.idAutor = docSnapshot.data()['idAutor'];
            _artigo.autor = docSnapshot.data()['autor'];
            _artigo.titulo = docSnapshot.data()['titulo'];
            _artigo.subTitulo = docSnapshot.data()['subTitulo'];
            _artigo.texto = docSnapshot.data()['texto'];
            _artigo.topico = docSnapshot.data()['topico'];
            _artigo.img = docSnapshot.data()['img'];
            _artigo.data = docSnapshot.data()['data'];
            artigos.add(_artigo);
          }
      });
      return artigos;
    }on FirebaseException catch(e){
      _mensagens.state = false;
      _mensagens.mensagemError = 'Error';
      return _mensagens.scaffoldMessege(context);
    }
  }

  _acessarDadosFrases(BuildContext context)async{
    final Mensagens _mensagens = Mensagens();
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore dbFrases = FirebaseFirestore.instance;
    List<Frase> _frases = [];
    final docRef = await dbFrases.collection(CollectionsNames.frases);
    await docRef.get().then((querySnapshot){
      for(var docSnapshot in querySnapshot.docs){
        Frase _frase = Frase();
        _frase.frase = docSnapshot.data()['frase'];
        _frase.autor = docSnapshot.data()['autor'];
        _frases.add(_frase);
      }
    });
    return _frases;
  }

  _acessarTopicos()async{
    FirebaseFirestore db = FirebaseFirestore.instance;
    List<String> topicos = [];
    await db.collection(CollectionsNames.topicos).orderBy('topico', descending: false).get().then((querySnapshot){
      for(var docSnapshot in querySnapshot.docs){
        topicos.add(docSnapshot.data()['topico']);
      }
    });
    return topicos;
  }

  _error(BuildContext context){
    final Mensagens _mensagens = Mensagens();
    print(ErrorStrings.naoFoiPossivelAcessarDado);
    _mensagens.mensagemError = ErrorStrings.naoFoiPossivelAcessarDado;
    _mensagens.state = false;
    return _mensagens.scaffoldMessege(context);
  }

}