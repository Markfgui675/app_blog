import 'package:flutter/cupertino.dart';
import '../models/TipoSalvarDataBase.dart';

abstract class DataBase{
  salvarDados(TipoSalvarDataBase tipoSalvarDataBase, BuildContext context, {dynamic args});
}

abstract class ExcluirDocDataBase{
  excluirDoc({required String collection, required String idDoc, required BuildContext context});
}

abstract class ExcluirArtigoSalvoDataBase{
  excluirArtigoSalvo({required String idUsuario, required String idArtigo, required BuildContext context});
}
