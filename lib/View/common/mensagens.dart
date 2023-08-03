import 'package:app_blog/View/resources/color_manager.dart';
import 'package:app_blog/View/resources/style_manager.dart';
import 'package:app_blog/View/resources/values_manager.dart';
import 'package:flutter/material.dart';

class Mensagens{

  String? _mensagemOk;
  String? _mensagemError;
  bool? _state;

  scaffoldMessege(BuildContext context){

    int? tempo;

    if(state){
     tempo = _calculoTempo(mensagemOk);
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(mensagemOk, style: getAlexandriaStyle(color: Colors.white),),
          elevation: AppSize.s2,
          backgroundColor: ColorManager.verde,
          duration: Duration(seconds: tempo),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
          showCloseIcon: true,
          closeIconColor: ColorManager.branco,
        )
      );
    } else {
      tempo = _calculoTempo(mensagemError);
      return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(mensagemError, style: getAlexandriaStyle(color: Colors.white),),
            elevation: AppSize.s2,
            backgroundColor: ColorManager.vermelho,
            duration: Duration(seconds: tempo),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(20),
            behavior: SnackBarBehavior.floating,
            showCloseIcon: true,
            closeIconColor: ColorManager.branco,
          )
      );
    }

  }

  int _calculoTempo(String mensagem) => (((mensagem.length).toDouble()/2)-4).toInt();

  bool get state => _state!;

  set state(bool value) {
    _state = value;
  }

  String get mensagemError => _mensagemError!;

  set mensagemError(String value) {
    _mensagemError = value;
  }

  String get mensagemOk => _mensagemOk!;

  set mensagemOk(String value) {
    _mensagemOk = value;
  }
}