import 'package:app_blog/ViewModel/dependency_injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ViewModel/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
  DependencyInjection.init();
}

// TODO: pegar strings soltas e centralizá-las no string_manager
// TODO: reutilizar alguns métodos e funções que aparecem com frequência no código, colocando-os na pasta common
// TODO: resolver questão do TipoSalvar e TipoAcessar, tornando-os acessíveis apenas pela viewmodel e não mais pela view
