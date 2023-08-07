import 'Usuario.dart';

class Artigo{
  String? _id;
  String? _idAutor;
  String? _titulo;
  String? _subTitulo;
  dynamic _texto;
  Usuario? _autor;
  String? _img;
  String? _topico;


  String get id => _id!;

  set id(String value) {
    _id = value;
  }

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

  Usuario get autor => _autor!;

  dynamic get texto => _texto;

  set texto(dynamic value) {
    _texto = value;
  }

  String get topico => _topico!;

  set topico(String value) {
    _topico = value;
  }

  String get idAutor => _idAutor!;

  set idAutor(String value) {
    _idAutor = value;
  }
}