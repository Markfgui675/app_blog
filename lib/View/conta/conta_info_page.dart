import 'package:app_blog/Model/repository/acessardados.dart';
import 'package:flutter/material.dart';
import '../../Model/models/TipoAcessoDataBase.dart';
import '../../Model/models/Usuario.dart';
import '../../Model/servicos/acessardados_service.dart';
import '../../ViewModel/conta/conta_viewmodel.dart';

class ContaInfoPage extends StatefulWidget {
  const ContaInfoPage({super.key});

  @override
  State<ContaInfoPage> createState() => _ContaInfoPageState();
}

class _ContaInfoPageState extends State<ContaInfoPage> {

  final ContaViewModel _viewModel = ContaViewModel(AcessarDadosRepository() as AcessarDados);
  Usuario usuario = Usuario();

  _bind() async {
    await _viewModel.acessarDados(TipoAcesso.acessarDadosUsuario);
    usuario = _viewModel.dados;
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100,
        width: 100,
        color: Colors.red,
      )
    );
  }
}
