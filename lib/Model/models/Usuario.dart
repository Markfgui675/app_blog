class Usuario{
  String? _idUsuario;
  String? _nome;
  String? _email;
  String? _senha;
  String? _sobre;
  List<dynamic>? _seguidores;
  List<dynamic>? _seguindo;
  List<dynamic>? _artigos;
  String? _profilePic;


  String get sobre => _sobre!;

  set sobre(String value) {
    _sobre = value;
  }

  String get idUsuario => _idUsuario!;

  set idUsuario(String value) {
    _idUsuario = value;
  }

  String get nome => _nome!;

  String get profilePic => _profilePic!;

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

  List<dynamic> get artigos => _artigos!;

  set artigos(List<dynamic> value) {
    _artigos = value;
  }

  List<dynamic> get seguindo => _seguindo!;

  set seguindo(List<dynamic> value) {
    _seguindo = value;
  }

  List<dynamic> get seguidores => _seguidores!;

  set seguidores(List<dynamic> value) {
    _seguidores = value;
  }

  String get senha => _senha!;

  set senha(String value) {
    _senha = value;
  }
}