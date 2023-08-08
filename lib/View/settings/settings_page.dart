import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../resources/color_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/style_manager.dart';
import '../resources/values_manager.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.branco,
        appBar: AppBar(
          title: Text(AppStrings.settings, style: getAlexandriaStyle(color: ColorManager.preto, fontSize: AppSize.s25),),
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
        body: Column()
      ),
    );
  }
}

