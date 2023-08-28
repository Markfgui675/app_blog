import 'package:app_blog/Model/models/TipoAcessoDataBase.dart';
import 'package:app_blog/View/resources/strings_manager.dart';
import 'package:app_blog/ViewModel/conta/conta_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../Model/models/Artigo.dart';
import '../resources/color_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/style_manager.dart';
import '../resources/values_manager.dart';
//ignore: must_be_immutable
class ArtigosPage extends StatefulWidget {
  ArtigosPage({super.key});

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
          if(_viewModel.artigosUsuario.isEmpty){
            return const Scaffold(
              backgroundColor: ColorManager.branco,
              body: Center(
                child: CircularProgressIndicator(backgroundColor: ColorManager.marrom, color: ColorManager.branco,),
              ),
            );
          }else{
            return RefreshIndicator(
              backgroundColor: ColorManager.marrom,
              color: ColorManager.branco,
              onRefresh: ()=>_bind(),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                  itemCount: _viewModel.artigosUsuario.length,
                  itemBuilder: (_,i){
                    Artigo artigo = _viewModel.artigosUsuario[i];
                    return Dismissible(
                      background: Container(
                        color: ColorManager.vermelho,
                        child: const Padding(
                          padding: EdgeInsets.only(right: AppMargin.m16, left: AppMargin.m16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.delete, color: ColorManager.branco, size: AppSize.s40,),
                              Icon(Icons.delete, color: ColorManager.branco, size: AppSize.s40,),
                            ],
                          ),
                        ),
                      ),
                      onDismissed: (DismissDirection direction){
                        // TODO: mostra um showDialog antes de deletar, para confirmar tal
                        print('excluir ${artigo.titulo}');
                      },
                      key: ValueKey<Artigo>(artigo),
                      child: GestureDetector(
                        onTap: ()=>Navigator.pushNamed(context, Routes.leituraPage, arguments: artigo),
                        child: _cardArtigo(artigo),
                      )
                    );
                  }
              ),
            );
          }
        },
      ),
    );
  }

  Widget _cardArtigo(Artigo artigo){
    return Container(
        width: double.infinity,
        height: 145,
        padding: const EdgeInsets.all(AppPadding.p5),
        margin: const EdgeInsets.all(AppMargin.m18),
        decoration: BoxDecoration(
            color: ColorManager.branco,
            borderRadius: BorderRadius.circular(AppSize.s20),
            boxShadow: [
              BoxShadow(color: ColorManager.cinza, offset: const Offset(0,0), blurRadius: AppSize.s8)
            ]
        ),
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.all(AppMargin.m6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s8),
                      color: Colors.black,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(artigo.img)
                      )
                  ),
                )
            ),
            Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: AppSize.s6,),
                          Text(artigo.titulo, style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s16),)
                        ],
                      ),
                    ),
                    Text(artigo.topico, style: getAlexandriaStyle(color: ColorManager.marrom),),
                    const SizedBox(height: AppSize.s2,),
                    Text(artigo.data, style: getAlexandriaStyle(color: ColorManager.cinza),),
                  ],
                )
            ),
          ],
        )
    );
  }

}

