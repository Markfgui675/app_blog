import 'package:app_blog/Model/models/TipoSalvarDataBase.dart';
import 'package:app_blog/View/resources/strings_manager.dart';
import 'package:app_blog/ViewModel/conta/conta_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import '../../Model/models/TipoAcessoDataBase.dart';
import '../resources/color_manager.dart';
import '../resources/style_manager.dart';
import '../resources/values_manager.dart';
import 'dart:io';

class EditorPage extends StatefulWidget {
  const EditorPage({Key? key}) : super(key: key);

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {


  final ContaViewModel _viewModel = ContaViewModel();
  late File _image;
  final imagePicker = ImagePicker();

  _bind() async{
    await _viewModel.acessarDados(TipoAcesso.acessarDadosUsuario, context);
    _nome.text = _viewModel.dadosUsuario[0].nome;
    _sobre.text = _viewModel.dadosUsuario[0].sobre;
  }

  Future _getImageCamera()async{
    final image = await imagePicker.pickImage(source: ImageSource.camera);
  }

  Future _getImageGallery()async{
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
  }

  final TextEditingController _nome = TextEditingController();
  final TextEditingController _sobre = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.branco,
        appBar: AppBar(
          title: Text(AppStrings.editarPerfil, style: getAlexandriaStyle(color: ColorManager.preto, fontSize: AppSize.s25),),
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
        body: Observer(
          builder: (_){
            if(_viewModel.dadosUsuario.isEmpty){
              return const Center(child: CircularProgressIndicator(
                color: ColorManager.marrom,
              ),);
            } else {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [

                    // Foto Usuário
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppPadding.p2),
                      child: Center(
                        child: CircleAvatar(
                          maxRadius: 80,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(_viewModel.dadosUsuario[0].profilePic),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: _modalCamera,
                            icon: const Icon(Icons.add_a_photo_outlined, color: ColorManager.marrom, size: AppSize.s30,)
                        )
                      ],
                    ),


                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: AppSize.s25),
                            child: TextFormField(
                              cursorColor: ColorManager.marrom,
                              keyboardType: TextInputType.emailAddress,
                              controller: _nome,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: AppStrings.nome
                              ),
                              validator: (value){
                                if(value!.isEmpty || value.length < 2){
                                  return ErrorStrings.nomeValido;
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: AppSize.s20,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: AppSize.s25),
                            child: TextFormField(
                              cursorColor: ColorManager.marrom,
                              textInputAction: TextInputAction.newline,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              controller: _sobre,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: AppStrings.sobre
                              ),
                              validator: (value){
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: AppSize.s85,
                      width: double.infinity,
                      color: Colors.transparent,
                      padding: const EdgeInsets.all(AppPadding.p12),
                      child: Center(
                        child: GestureDetector(
                          onTap: (){
                            if(formKey.currentState!.validate()){
                              var res = _viewModel.salvarDados(
                                  TipoSalvar.salvarDadosUsuario, context,
                                  nome: _nome.text,
                                  sobre: _sobre.text
                              );
                              return res;
                            }
                          },
                          child: Container(
                            height: double.infinity,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: ColorManager.marrom,
                                borderRadius: BorderRadius.circular(AppSize.s10)
                            ),
                            child: Center(
                              child: Text(AppStrings.salvarMudancas, style: getAliceStyle(color: ColorManager.branco, fontSize: AppSize.s18),),
                            ),
                          ),
                        ),
                      ),
                    )

                  ],
                ),
              );
            }
          },
        ),
      )
    );
  }

  Future _modalCamera(){
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(AppSize.s30),
          topLeft: Radius.circular(AppSize.s30)
        )
      ),
      context: context,
      builder: (context){
        return Container(
          height: AppSize.s180,
          padding: const EdgeInsets.all(AppPadding.p12),
          decoration: BoxDecoration(
            color: ColorManager.branco,
            borderRadius: BorderRadius.circular(AppSize.s30)
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: ()=>Navigator.pop(context),
                    icon: const Icon(Icons.close, color: ColorManager.marrom, size: AppSize.s30,)
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        height: AppSize.s48,
                        width: AppSize.s48,
                        decoration: BoxDecoration(
                          color: ColorManager.cinza,
                          borderRadius: BorderRadius.circular(AppSize.s48)
                        ),
                        child: Center(
                          child: IconButton(
                              onPressed: _getImageCamera,
                              icon: const Icon(Icons.camera_alt_outlined, color: ColorManager.marrom,)
                          ),
                        ),
                      ),
                      Text(AppStrings.camera, style: getAlexandriaStyle(color: ColorManager.preto),)
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: AppSize.s48,
                        width: AppSize.s48,
                        decoration: BoxDecoration(
                            color: ColorManager.cinza,
                            borderRadius: BorderRadius.circular(AppSize.s48)
                        ),
                        child: Center(
                          child: IconButton(
                              onPressed: ()=>_getImageGallery(),
                              icon: const Icon(Icons.photo, color: ColorManager.marrom,)
                          ),
                        ),
                      ),
                      Text(AppStrings.galeria, style: getAlexandriaStyle(color: ColorManager.preto),)
                    ],
                  ),
                ],
              )
            ],
          ),
        );
      }
    );
  }

}

