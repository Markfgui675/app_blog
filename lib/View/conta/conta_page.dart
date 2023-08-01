import 'package:app_blog/Model/models/TipoAcessoDataBase.dart';
import 'package:app_blog/Model/models/Usuario.dart';
import 'package:app_blog/Model/servicos/acessardados_service.dart';
import 'package:app_blog/View/conta/conta_info_page.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.branco,
        body: Obx(
                (){
              return _authController.user.value == null ? LoginPage() : ContaInfoPage();
            }
        )
    );
  }

}

