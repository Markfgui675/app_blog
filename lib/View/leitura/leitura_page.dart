import 'package:app_blog/View/resources/style_manager.dart';
import 'package:app_blog/View/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../Model/models/Artigo.dart';
import '../resources/color_manager.dart';

//ignore: must_be_immutable
class LeituraPage extends StatelessWidget {
  Artigo artigo;
  LeituraPage({super.key, required this.artigo});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: ColorManager.branco,
      appBar: AppBar(
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            
            Container(
              width: double.infinity,
              height: AppSize.s280,
              margin: const EdgeInsets.only(right: AppMargin.m30, left: AppMargin.m30, bottom: AppMargin.m10),
              decoration: BoxDecoration(
                color: ColorManager.preto,
                borderRadius: BorderRadius.circular(AppSize.s20),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(artigo.img)
                )
              ),
            ),
            
            
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(right: AppMargin.m30, left: AppMargin.m30, bottom: AppMargin.m10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Por ${artigo.autor}', style: getAlexandriaStyle(color: ColorManager.marrom),),
                  Text(' - ${artigo.data}', style: getAlexandriaStyle(color: ColorManager.preto),),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(right: AppMargin.m30, left: AppMargin.m30, bottom: AppMargin.m10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(artigo.titulo, style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s30),),
                  const SizedBox(height: AppSize.s6,),
                  Text(artigo.subTitulo, style: getAliceStyle(color: ColorManager.marrom, fontSize: AppSize.s20),),
                  const SizedBox(height: AppSize.s20,),
                  Text(artigo.texto, style: getAlexandriaStyle(color: ColorManager.preto, fontSize: AppSize.s16),)
                ],
              ),
            )
            
          ],
        ),
      ),
    );
  }
}

