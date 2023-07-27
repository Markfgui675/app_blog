import 'package:app_blog/Model/repository/acessardados.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AcessarDadosRepository implements AcessarDados{
  @override
  acessarDados() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;
    User? user = await auth.currentUser;

  }

}