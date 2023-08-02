import 'package:app_blog/View/resources/color_manager.dart';
import 'package:app_blog/View/resources/style_manager.dart';
import 'package:app_blog/View/resources/values_manager.dart';
import 'package:flutter/material.dart';

class Mensagens{

  String mensagemOk;
  String mensagemError;
  bool state;

  Mensagens({this.mensagemOk =  'Ok', this.mensagemError =  'Error', required this.state});

  scaffoldMessege(BuildContext context){

    if(state){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(mensagemOk, style: getAlexandriaStyle(color: Colors.white),),
          elevation: AppSize.s2,
          backgroundColor: ColorManager.verde,
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
        )
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(mensagemError, style: getAlexandriaStyle(color: Colors.white),),
            elevation: AppSize.s2,
            backgroundColor: ColorManager.vermelho,
            duration: const Duration(seconds: 3),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(20),
            behavior: SnackBarBehavior.floating,
          )
      );
    }

  }

}