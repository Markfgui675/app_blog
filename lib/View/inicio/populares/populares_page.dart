import 'package:app_blog/View/resources/assets_manager.dart';
import 'package:app_blog/View/resources/color_manager.dart';
import 'package:app_blog/View/resources/strings_manager.dart';
import 'package:app_blog/View/resources/style_manager.dart';
import 'package:app_blog/View/resources/values_manager.dart';
import 'package:app_blog/ViewModel/inicio/inicio_viewmodel.dart';
import 'package:flutter/material.dart';
import '../../../Model/models/Artigo.dart';
import '../../resources/routes_manager.dart';
import '../populares_widget.dart';

class PopularesPage extends StatefulWidget {
  const PopularesPage({super.key});

  @override
  State<PopularesPage> createState() => _PopularesPageState();
}

class _PopularesPageState extends State<PopularesPage> {

  Artigo artigo1 = Artigo();
  List<Artigo> artigos = [];
  final InicioViewModel _viewModel = InicioViewModel();

  // TODO: implementar as artigos de cada tópico
  // ideias:
  //  - gerar automaticamente cada seção de tópico com base nos tópicos fonecidos pelo servidor.

  _bind()async{
    await _viewModel.recuperarArtigosPopulares(context);
    await _viewModel.recuperarArtigosEmAlta(context);
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  Widget build(BuildContext context) {

    artigo1.titulo = 'titulo 1';
    artigo1.subTitulo = 'subitutulo 1';
    artigo1.texto = 'texto 1';
    artigo1.autor = 'Autor 1';
    artigo1.img = AssetsManager.image;
    artigo1.topico = 'Esportes';
    for(int i = 0; i < 4; i++){
      artigos.add(artigo1);
    }
    print(artigos);


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _iniciais(),
        PopularesWidget(
          artigos: artigos,
          topico: AppStrings.emAlta,
        ),
      ],
    );
  }

  Widget _iniciais(){
    return Padding(
      padding: const EdgeInsets.only(top: AppPadding.p20, bottom: AppPadding.p20),
      child: SizedBox(
        height: AppSize.s380,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: artigos.length,
          itemBuilder: (context, index){
            Artigo artigo = artigos[index];
            return GestureDetector(
              onTap: () => Navigator.pushNamed(context, Routes.leituraPage, arguments: artigo),
              child: Container(
                height: AppSize.s300,
                width: AppSize.s300,
                margin: const EdgeInsets.only(left: AppMargin.m10, right: AppMargin.m2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s25),
                  image: DecorationImage(
                    image: AssetImage(artigo.img),
                    fit: BoxFit.cover
                  )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: AppSize.s300,
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppPadding.p20),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(AppSize.s25),
                          bottomLeft: Radius.circular(AppSize.s25)
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black38,
                            Colors.black
                          ]
                        )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(artigo.titulo, style: getAliceStyle(color: ColorManager.branco, fontSize: AppSize.s30),),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }

}

