import 'package:app_blog/View/resources/assets_manager.dart';
import 'package:app_blog/View/resources/color_manager.dart';
import 'package:app_blog/View/resources/strings_manager.dart';
import 'package:app_blog/View/resources/style_manager.dart';
import 'package:app_blog/View/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:advanced_icon/advanced_icon.dart';
import 'package:line_icons/line_icon.dart';

import '../../Model/Artigo.dart';
import '../resources/routes_manager.dart';

class PopularesPage extends StatefulWidget {
  const PopularesPage({super.key});

  @override
  State<PopularesPage> createState() => _PopularesPageState();
}

class _PopularesPageState extends State<PopularesPage> {

  AdvancedIconState _state = AdvancedIconState.primary;

  void _changeState(){
    setState(() {
      if(_state == AdvancedIconState.primary){
        _state = AdvancedIconState.secondary;
      } else {
        _state = AdvancedIconState.primary;
      }
    });
  }

  Artigo artigo1 = Artigo();

  List<Artigo> artigos = [];

  @override
  Widget build(BuildContext context) {

    artigo1.titulo = 'titulo 1';
    artigo1.subTitulo = 'subitutulo 1';
    artigo1.texto = 'texto 1';
    artigo1.autor = 'autor 1';
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
        _populares()
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
                        decoration: BoxDecoration(
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
                            Text(artigo.subTitulo, style: getAliceStyle(color: ColorManager.branco, fontSize: AppSize.s16),),
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
  
  Widget _populares(){
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.p12),
            child: Text(AppStrings.emAlta, style: getAlexandriaStyle(color: ColorManager.preto, fontSize: AppSize.s25),),
          ),
          const SizedBox(height: AppSize.s10,),
          SizedBox(
            height: AppSize.s400,
            width: double.infinity,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10
              ),
              itemCount: artigos.length,
              itemBuilder: (_, index){
                Artigo artigo = artigos[index];
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(context, Routes.leituraPage, arguments: artigo),
                  child: Container(
                    margin: const EdgeInsets.all(AppMargin.m12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.s20),
                        color: ColorManager.branco,
                        boxShadow: [
                          BoxShadow(
                              color: ColorManager.cinza,
                              offset: const Offset(0, 1),
                              blurRadius: AppSize.s10
                          )
                        ]
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 3,
                            child: Container(
                              margin: const EdgeInsets.all(AppMargin.m6),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(AppSize.s20),
                                image: DecorationImage(
                                  image: AssetImage(artigo.img),
                                  fit: BoxFit.cover
                                )
                              ),
                            )
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding: const EdgeInsets.all(AppSize.s2),
                            margin: const EdgeInsets.only(left: AppMargin.m6),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(artigo.titulo, style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s20),),
                                Text(artigo.subTitulo, style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s10),),
                                Text(artigo.topico, style: getAlexandriaStyle(color: ColorManager.marrom, fontSize: AppSize.s16),),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },

            )
          )
        ],
      ),
    );
  }

}

