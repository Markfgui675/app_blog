import 'package:app_blog/Model/models/TipoAcessoDataBase.dart';
import 'package:app_blog/Model/models/Usuario.dart';
import 'package:app_blog/Model/servicos/acessardados_service.dart';
import 'package:app_blog/ViewModel/conta/conta_viewmodel.dart';
import 'package:app_blog/ViewModel/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../login/login_page.dart';
import '../resources/color_manager.dart';

class ContaPage extends StatefulWidget {
  const ContaPage({super.key});

  @override
  State<ContaPage> createState() => _ContaPageState();
}

class _ContaPageState extends State<ContaPage> {

  final AuthController _authController = AuthController();
  final ContaViewModel _viewModel = ContaViewModel(AcessarDadosRepository());
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
        backgroundColor: ColorManager.branco,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: Obx(
                      (){
                    return _authController.user.value == null ? LoginPage() : _contaWidget();
                  }
              ),
            )
          ],
        )
    );
  }

  Widget _contaWidget(){
    return Column(
      children: [
        Text(usuario.nome),
        Text(usuario.email),
      ],
    );
  }

}

