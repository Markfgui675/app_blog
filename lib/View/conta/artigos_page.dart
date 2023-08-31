import 'package:app_blog/Model/data/collections_names.dart';
import 'package:app_blog/View/resources/strings_manager.dart';
import 'package:app_blog/ViewModel/conta/conta_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
    await _viewModel.acessarQuantidadeArtigos(context);
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
                    return Slidable(
                      key: ValueKey<Artigo>(artigo),
                      startActionPane: ActionPane(
                        motion: const DrawerMotion(),
                        dragDismissible: false,
                        children: [
                          SlidableAction(
                            onPressed: (_)=>_showDialog(artigo),
                            backgroundColor: ColorManager.vermelho,
                            icon: Icons.delete_outline_outlined,
                            label: 'Deletar Artigo',
                          )
                        ],
                      ),
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
        height: AppSize.s145,
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
                      height: AppSize.s100,
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

  _showDialog(Artigo artigo){
    showDialog(
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
              height: AppSize.s150,
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
                            dynamic res = _viewModel.excluirArtigo(
                              collection: CollectionsNames.artigos,
                              idDoc: artigo.id, context: context);
                            Navigator.pop(context);
                            return res;
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
  }

  Widget _button({required String tituloBotao, required VoidCallback onPressed}){
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: AppSize.s80,
        height: AppSize.s40,
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

