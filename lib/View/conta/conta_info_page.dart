import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:app_blog/View/resources/color_manager.dart';
import 'package:app_blog/View/resources/routes_manager.dart';
import 'package:app_blog/View/resources/strings_manager.dart';
import 'package:app_blog/View/resources/style_manager.dart';
import 'package:app_blog/View/resources/values_manager.dart';
import 'package:flutter/material.dart';
import '../../Model/models/TipoAcessoDataBase.dart';
import '../../ViewModel/conta/conta_viewmodel.dart';

class ContaInfoPage extends StatefulWidget {
  const ContaInfoPage({super.key});

  @override
  State<ContaInfoPage> createState() => _ContaInfoPageState();
}

class _ContaInfoPageState extends State<ContaInfoPage> {

  final ContaViewModel _viewModel = ContaViewModel();

  _bind() async {
    var res = await _viewModel.acessarDados(TipoAcesso.acessarDadosUsuario, context);
    return res;
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
            if(_viewModel.dadosUsuario.isEmpty){
              return const Center(child: CircularProgressIndicator(
                color: ColorManager.marrom,
              ),);
            } else {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [

                    // Foto Usuário
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppPadding.p20),
                      child: Center(
                        child: CircleAvatar(
                          maxRadius: 80,
                          backgroundColor: ColorManager.preto,
                          backgroundImage: _viewModel.dadosUsuario[0].profilePic == '' ? null : NetworkImage(_viewModel.dadosUsuario[0].profilePic),
                        ),
                      ),
                    ),


                    // Nome Usuário
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppPadding.p5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(_viewModel.dadosUsuario[0].nome,
                            style: getAlexandriaStyle(color: ColorManager.preto, fontSize: AppSize.s25),)
                        ],
                      ),
                    ),


                    // Info Usuário
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppPadding.p5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          // Seguidores
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(context, Routes.seguirSeguindoPage, arguments: AppStrings.seguidores),
                            child: Container(
                              height: AppSize.s100,
                              width: AppSize.s100,
                              decoration: BoxDecoration(
                                  color: ColorManager.marrom,
                                  borderRadius: BorderRadius.circular(AppSize.s20)
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(_viewModel.dadosUsuario[0].seguidores.length.toString(),
                                      style: getAlexandriaStyle(color: ColorManager.branco, fontSize: AppSize.s30),),
                                    Text(AppStrings.seguidores,
                                      style: getAliceStyle(color: ColorManager.branco, fontSize: AppSize.s16),)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSize.s10,),

                          // Seguindo
                          GestureDetector(
                            onTap: ()=>Navigator.pushNamed(context, Routes.seguirSeguindoPage, arguments: AppStrings.seguindo),
                            child: Container(
                              height: AppSize.s100,
                              width: AppSize.s100,
                              decoration: BoxDecoration(
                                  color: ColorManager.marrom,
                                  borderRadius: BorderRadius.circular(AppSize.s20)
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(_viewModel.dadosUsuario[0].seguindo.length.toString(),
                                      style: getAlexandriaStyle(color: ColorManager.branco, fontSize: AppSize.s30),),
                                    Text(AppStrings.seguindo,
                                      style: getAliceStyle(color: ColorManager.branco, fontSize: AppSize.s16),)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSize.s10,),

                          // Artigos
                          GestureDetector(
                            onTap: ()=>Navigator.pushNamed(context, Routes.artigosPage),
                            child: Container(
                              height: AppSize.s100,
                              width: AppSize.s100,
                              decoration: BoxDecoration(
                                  color: ColorManager.marrom,
                                  borderRadius: BorderRadius.circular(AppSize.s20)
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(_viewModel.dadosUsuario[0].artigos.length.toString(),
                                      style: getAlexandriaStyle(color: ColorManager.branco, fontSize: AppSize.s30),),
                                    Text(AppStrings.artigos,
                                      style: getAliceStyle(color: ColorManager.branco, fontSize: AppSize.s16),)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),


                    // Botão editar
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppPadding.p5),
                      child: Center(
                        child: _buttonEditar(),
                      ),
                    ),


                    // Sobre
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppPadding.p20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [Text(AppStrings.sobre, style: getAlexandriaStyle(color: ColorManager.preto, fontSize: AppSize.s25),)],
                          ),
                          Column(

                          )
                        ],
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
