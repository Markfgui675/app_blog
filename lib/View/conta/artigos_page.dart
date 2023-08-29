import 'package:app_blog/Model/models/TipoAcessoDataBase.dart';
import 'package:app_blog/View/resources/assets_manager.dart';
import 'package:app_blog/View/resources/strings_manager.dart';
import 'package:app_blog/ViewModel/conta/conta_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lottie/lottie.dart';
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
                      resizeDuration: const Duration(milliseconds: 800),
                      onResize: (){
                        _bind();
                      },
                      confirmDismiss: (DismissDirection direction){
                        ConfirmDismissCallback confirmDismissCallback;
                        return showDialog(
                            context: context,
                            builder: (context){
                              return Dialog(
                                insetAnimationCurve: Curves.bounceInOut,
                                insetAnimationDuration: const Duration(seconds: 1),
                                backgroundColor: ColorManager.branco,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(AppSize.s20),
                                ),
                                child: Container(
                                  height: 150,
                                  padding: const EdgeInsets.all(AppPadding.p12),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('Tem certeza que quer excluir o artigo? Essa ação é irreversível.',
                                        style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s18),
                                        textAlign: TextAlign.center,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          _button(tituloBotao: 'Não', onPressed: (){
                                            return Navigator.of(context).pop(false);
                                          }),
                                          _button(
                                            tituloBotao: 'Sim',
                                            onPressed: (){
                                              print('deletar ${artigo.titulo}');
                                              return Navigator.of(context).pop(true);
                                            }
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                        );
                      },
                      background: Container(
                        color: ColorManager.vermelho,
                        child: Padding(
                          padding: const EdgeInsets.only(right: AppMargin.m2, left: AppMargin.m2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Lottie.asset(JsonManager.excluir, width: 120),
                              Lottie.asset(JsonManager.excluir, width: 120),
                            ],
                          ),
                        ),
                      ),
                      onDismissed: (DismissDirection direction){
                        // TODO: mostra um showDialog antes de deletar, para confirmar tal

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

  Widget _button({required String tituloBotao, required VoidCallback onPressed}){
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 80,
        height: 40,
        padding: const EdgeInsets.all(AppPadding.p5),
        decoration: BoxDecoration(
            color: ColorManager.marrom,
            borderRadius: BorderRadius.circular(AppSize.s10)
        ),
        child: Center(
          child: Text(tituloBotao, style: getAlexandriaStyle(color: ColorManager.branco, fontSize: AppSize.s12),),
        ),
      ),
    );
  }

}

