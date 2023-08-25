import 'package:app_blog/View/resources/style_manager.dart';
import 'package:app_blog/View/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Model/models/Artigo.dart';
import '../resources/color_manager.dart';

class LeituraPage extends StatelessWidget {
  Artigo artigo;

  LeituraPage({super.key, required this.artigo});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: ColorManager.branco,
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: ColorManager.branco,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                  color: ColorManager.preto,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(artigo.img)
                  )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed:()=>Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_rounded, color: ColorManager.branco)
                  )
                ],
              ),
            ),
            const SizedBox(height: AppSize.s20,),
            Text(artigo.titulo, style: getAliceStyle(color: ColorManager.preto,),)
          ],
        ),
      ),
    );
  }
}

