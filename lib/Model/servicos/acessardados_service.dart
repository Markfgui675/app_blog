import 'package:app_blog/Model/data/collections_names.dart';
import 'package:app_blog/Model/models/TipoAcessoDataBase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../repository/acessardados.dart';

class AcessarDadosRepository implements AcessarDados{

  List<String> _info = [];

  @override
  acessarDados(TipoAcessoDataBase tipoAcesso) {

    switch(tipoAcesso.tipo){

      case TipoAcesso.acessarDadosUsuario:
        return _acessarDadosUsuario();

    }

  }

  _acessarDadosUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore dbUsers = FirebaseFirestore.instance;
    User? user = await auth.currentUser;
    String _idUsuario = user!.uid;
    final docRef = await dbUsers.collection(CollectionsNames.usuarios).doc(_idUsuario);

    await docRef.get().then((DocumentSnapshot doc){
      final dados = doc.data() as Map<String, dynamic>;
      _info.clear();
      _info.add(dados['nome']);
      _info.add(dados['email']);
      _info.add(dados['profilePic']);
      print(_info);
    }, onError: (e){
      // TODO: fazer tratamento de erros
      print(e.toString());
    });
    print('Antes do return: '+_info.toString());
    return _info;
  }

}