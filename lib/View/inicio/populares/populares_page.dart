import 'package:app_blog/View/resources/assets_manager.dart';
import 'package:app_blog/View/resources/color_manager.dart';
import 'package:app_blog/View/resources/strings_manager.dart';
import 'package:app_blog/View/resources/style_manager.dart';
import 'package:app_blog/View/resources/values_manager.dart';
import 'package:app_blog/ViewModel/inicio/inicio_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:line_icons/line_icon.dart';
import '../../../Model/models/Artigo.dart';
import '../../resources/routes_manager.dart';
import '../populares_widget.dart';

class PopularesPage extends StatefulWidget {
  const PopularesPage({super.key});

  @override
  State<PopularesPage> createState() => _PopularesPageState();
}

class _PopularesPageState extends State<PopularesPage> {

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: AppPadding.p20, bottom: AppPadding.p20),
          child: SizedBox(
            height: AppSize.s380,
            child: Observer(
              builder: (_){
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: _viewModel.artigosPopulares.length,
                  itemBuilder: (_,i){
                    Artigo artigo = _viewModel.artigosPopulares[i];
                    return GestureDetector(
                      onTap: () => Navigator.pushNamed(context, Routes.leituraPage, arguments: artigo),
                      child: Container(
                        height: AppSize.s300,
                        width: AppSize.s300,
                        margin: const EdgeInsets.only(left: AppMargin.m10, right: AppMargin.m2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.s20),
                            image: DecorationImage(
                                image: NetworkImage(artigo.img),
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
                                      bottomRight: Radius.circular(AppSize.s20),
                                      bottomLeft: Radius.circular(AppSize.s20)
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
                                  Text(artigo.titulo, style: getAliceStyle(color: ColorManager.branco, fontSize: AppSize.s30),)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),



        PopularesWidget(
          artigos: _viewModel.artigosEmAlta,
          topico: AppStrings.emAlta,
        ),
      ],
    );
  }

}

