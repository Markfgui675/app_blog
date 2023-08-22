import 'package:app_blog/Model/data/collections_names.dart';
import 'package:app_blog/Model/models/TipoSalvarDataBase.dart';
import 'package:app_blog/Model/repository/database.dart';
import 'package:app_blog/View/common/mensagens.dart';
import 'package:app_blog/View/resources/strings_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../models/Usuario.dart';

class SalvarDados implements DataBase{

  final Mensagens _mensagens = Mensagens();

  @override
  salvarDados(TipoSalvarDataBase tipoSalvarDataBase, BuildContext context, {dynamic args}) {

    switch(tipoSalvarDataBase.tipo){

      case TipoSalvar.salvarDadosUsuario:
        return _salvarDadosUsuario(context, args: args);

    }

  }

  _salvarDadosUsuario(BuildContext context, {Usuario? args}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = await auth.currentUser;
    FirebaseFirestore dbUser = FirebaseFirestore.instance;
    Map<String, String> _dadosAtualizar = {
      'nome':args!.nome,
      'sobre':args.sobre
    };
    try{
      dbUser.collection(CollectionsNames.usuarios).doc(user!.uid).update(_dadosAtualizar)
        .then((value){
        _mensagens.mensagemOk = SuccessStrings.dadosAlterados;
        _mensagens.state = true;
        return _mensagens.scaffoldMessege(context);
      });
    } on FirebaseAuthException catch(e){
      _mensagens.mensagemError = ErrorStrings.dadosNaoAlterados;
      _mensagens.state = false;
      return _mensagens.scaffoldMessege(context);
    }
  }
  
}
