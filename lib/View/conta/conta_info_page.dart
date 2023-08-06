import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:app_blog/View/resources/color_manager.dart';
import 'package:app_blog/View/resources/routes_manager.dart';
import 'package:app_blog/View/resources/strings_manager.dart';
import 'package:app_blog/View/resources/style_manager.dart';
import 'package:app_blog/View/resources/values_manager.dart';
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

  ContaViewModel _viewModel = ContaViewModel();

  _bind() async {
    await _viewModel.acessarDados(TipoAcesso.acessarDadosUsuario);
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.branco,
        body: Observer(
          builder: (_){
            if(_viewModel.dadosUsuario.length == 0){
              return const Center(child: CircularProgressIndicator(),);
            } else {
              List _dados = _viewModel.dadosUsuario;
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppPadding.p20),
                      child: const Center(
                        child: CircleAvatar(
                          maxRadius: 80,
                          backgroundColor: ColorManager.preto,
                          //backgroundImage: usuario.profilePic == '' ? null : NetworkImage(usuario.profilePic),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppPadding.p5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Marcos', style: getAlexandriaStyle(color: ColorManager.preto, fontSize: AppSize.s25),)
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppPadding.p5),
                      child: Center(
                        child: _buttonEditar(),
                      ),
                    )
                  ],
                ),
              );
            }
          },
        )
      )
    );
  }
  
  

  Widget _buttonEditar(){
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.editorPage),
      child: Container(
        decoration: BoxDecoration(
            color: ColorManager.cinza,
            borderRadius: BorderRadius.circular(AppSize.s20)
        ),
        padding: const EdgeInsets.all(AppPadding.p1),
        child: Container(
          width: 150,
          height: 45,
          decoration: BoxDecoration(
              color: ColorManager.branco,
              borderRadius: BorderRadius.circular(AppSize.s20)
          ),
          child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(AppStrings.editarPerfil, style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s16),),
                  const Icon(Icons.edit, size: AppSize.s18,)
                ],
              )
          ),
        ),
      ),
    );
  }

}
