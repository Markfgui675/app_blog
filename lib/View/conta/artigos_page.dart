import 'package:app_blog/Model/models/TipoAcessoDataBase.dart';
import 'package:app_blog/View/resources/strings_manager.dart';
import 'package:app_blog/ViewModel/conta/conta_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../Model/models/Artigo.dart';
import '../resources/color_manager.dart';
import '../resources/style_manager.dart';
import '../resources/values_manager.dart';

class ArtigosPage extends StatefulWidget {
  const ArtigosPage({Key? key}) : super(key: key);

  @override
  State<ArtigosPage> createState() => _ArtigosPageState();
}

class _ArtigosPageState extends State<ArtigosPage> {

  final ContaViewModel _viewModel = ContaViewModel();

  _bind()async{
    await _viewModel.acessarQuantidadeArtigos(TipoAcesso.acessarQuantidadeArtigos, context);
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
      appBar: AppBar(
        title: Text(AppStrings.artigos, style: getAlexandriaStyle(color: ColorManager.preto, fontSize: AppSize.s25),),
        backgroundColor: ColorManager.branco,
        leading: Builder(
          builder: (context){
            return IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_rounded, color: ColorManager.preto,)
            );
          }
        ),
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: ColorManager.branco,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Observer(
        builder: (_){
          return ListView.builder(
            itemCount: _viewModel.artigosUsuario.length,
            itemBuilder: (_,i){
              print(_viewModel.artigosUsuario[i]);
              return Container(
                width: double.infinity,
                height: 420,
                padding: const EdgeInsets.all(AppPadding.p5),
                margin: const EdgeInsets.all(AppMargin.m6),
                decoration: BoxDecoration(
                  color: ColorManager.branco,
                  borderRadius: BorderRadius.circular(AppSize.s20)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.red
                        ),
                      )
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(_viewModel.artigosUsuario[i].titulo),
                          Text('Subtitulo'),
                          Text('Tópico'),
                          Text('Autor')
                        ],
                      )
                    )
                  ],
                ),
              );
            }
          );
        },
      ),
    );
  }
}

