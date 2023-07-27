import 'Artigo.dart';

class Usuario{
  String? _idUsuario;
  String? _nome;
  String? _email;
  String? _senha;
  Usuario? _seguidores;
  Usuario? _seguindo;
  Artigo? _artigos;
  String _profilePic = '';

  String get idUsuario => _idUsuario!;

  set idUsuario(String value) {
    _idUsuario = value;
  }

  String get nome => _nome!;

  String get profilePic => _profilePic;

  set profilePic(String value) {
    _profilePic = value;
  }

  String get email => _email!;

  set email(String value) {
    _email = value;
  }

  set nome(String value) {
    _nome = value;
  }

  Artigo get artigos => _artigos!;

  set artigos(Artigo value) {
    _artigos = value;
  }

  Usuario get seguindo => _seguindo!;

  set seguindo(Usuario value) {
    _seguindo = value;
  }

  Usuario get seguidores => _seguidores!;

  set seguidores(Usuario value) {
    _seguidores = value;
  }

  String get senha => _senha!;

  set senha(String value) {
    _senha = value;
  }
}