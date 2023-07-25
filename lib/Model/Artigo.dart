import 'package:flutter/material.dart';

class Artigo{
  String? _titulo;
  String? _subTitulo;
  dynamic _texto;
  String? _autor;
  String? _img;
  String? _topico;

  String get titulo => _titulo!;

  set titulo(String value) {
    _titulo = value;
  }

  String get subTitulo => _subTitulo!;

  set subTitulo(String value) {
    _subTitulo = value;
  }

  String get img => _img!;

  set img(String value) {
    _img = value;
  }

  String get autor => _autor!;

  set autor(String value) {
    _autor = value;
  }

  dynamic get texto => _texto;

  set texto(dynamic value) {
    _texto = value;
  }

  String get topico => _topico!;

  set topico(String value) {
    _topico = value;
  }
}