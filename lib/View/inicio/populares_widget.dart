import 'package:flutter/material.dart';
import '../../Model/models/Artigo.dart';
import '../resources/color_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/style_manager.dart';
import '../resources/values_manager.dart';

//ignore: must_be_immutable
class PopularesWidget extends StatelessWidget {
  String topico;
  List<Artigo> artigos;
  PopularesWidget({super.key, required this.topico, required this.artigos});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: AppMargin.m55),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.p12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(topico, style: getAlexandriaStyle(color: ColorManager.preto, fontSize: AppSize.s25),),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, Routes.topicosSelecionados, arguments: topico),
                  child: Text(AppStrings.verMais, style: getAlexandriaStyle(color: ColorManager.marrom, fontSize: AppSize.s16),),
                )
              ],
            ),
          ),
          const SizedBox(height: AppSize.s10,),
          SizedBox(
            height: AppSize.s450,
            width: double.infinity,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: AppSize.s2.toInt(),
                mainAxisSpacing: AppSize.s10,
                crossAxisSpacing: AppSize.s10
              ),
              itemCount: artigos.length,
              itemBuilder: (_, index){
                Artigo artigo = artigos[index];
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(context, Routes.leituraPage, arguments: artigo),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppPadding.p5),
                    margin: const EdgeInsets.all(AppMargin.m18),
                    decoration: BoxDecoration(
                      color: ColorManager.branco,
                      borderRadius: BorderRadius.circular(AppSize.s20),
                      boxShadow: [
                        BoxShadow(color: ColorManager.cinza, offset: const Offset(0,0), blurRadius: AppSize.s8)
                      ]
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: const EdgeInsets.all(AppMargin.m2),
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
                            ],
                          )
                        ),
                      ],
                    )
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

