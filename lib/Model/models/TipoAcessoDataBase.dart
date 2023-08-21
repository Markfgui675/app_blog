class TipoAcessoDataBase{

  String? tipo;

  TipoAcessoDataBase({this.tipo});

}

sealed class TipoAcesso{
  static const String acessarDadosUsuario = 'acessarDadosUsuario';
  static const String acessarDadosFrases = 'acessarDadosFrases';
}
