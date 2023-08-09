import 'package:flutter/cupertino.dart';

import '../models/TipoSalvarDataBase.dart';

abstract class DataBase{
  salvarDados(TipoSalvarDataBase tipoSalvarDataBase, BuildContext context, {dynamic args});
}
