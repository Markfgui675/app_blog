import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../resources/color_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/style_manager.dart';
import '../resources/values_manager.dart';

class CriarArtigoPage extends StatefulWidget {
  const CriarArtigoPage({Key? key}) : super(key: key);

  @override
  State<CriarArtigoPage> createState() => _CriarArtigoPageState();
}

class _CriarArtigoPageState extends State<CriarArtigoPage> {

  final formKey = GlobalKey<FormState>();

  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _subTituloController = TextEditingController();
  final TextEditingController _textoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.branco,
      appBar: AppBar(
        title: Text(AppStrings.criarArtgio, style: getAlexandriaStyle(color: ColorManager.preto, fontSize: AppSize.s25),),
        backgroundColor: ColorManager.branco,
        leading: Builder(
          builder: (context){
            return IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_rounded, color: ColorManager.preto,)
            );
          }
        ),
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: ColorManager.branco,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Column(
        children: [

        ],
      )
    );
  }
}

