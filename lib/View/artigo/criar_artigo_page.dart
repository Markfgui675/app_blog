import 'dart:io';
import 'package:app_blog/Model/models/TipoAcessoDataBase.dart';
import 'package:app_blog/View/resources/assets_manager.dart';
import 'package:app_blog/ViewModel/conta/conta_viewmodel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
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

  final FirebaseStorage storage = FirebaseStorage.instance;

  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();

  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _subTituloController = TextEditingController();
  final TextEditingController _textoController = TextEditingController();

  final PageController _pageController = PageController(
    initialPage: 0
  );
  int _pageChanged = 0;

  final ContaViewModel _viewModel = ContaViewModel();
  _bind(){
    _viewModel.acessarDados(TipoAcesso.acessarDadosUsuario, context);
  }

  String filex = '';
  bool uploading = false;
  bool loading = true;
  double total = 0;
  dynamic arquivo;

  Future<XFile?> getImage() async{
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  pickAndUploadImage() async {
    XFile? file = await getImage();
    if(file != null){
      UploadTask task = await upload(file.path);
      task.snapshotEvents.listen((TaskSnapshot snapshot) async{
        if(snapshot.state == TaskState.running){
          setState(() {
            uploading = true;
            total = (snapshot.bytesTransferred/snapshot.totalBytes)*100;
          });
        } else if(snapshot.state == TaskState.success){
          arquivo = await snapshot.ref.getDownloadURL();
          setState(() {
            uploading = false;
            filex = file.path;
          });
        }
      });
    }
  }

  Future<UploadTask> upload(String path) async{
    File file = File(path);
    try{
      String ref = 'images/img-${DateTime.now().toString()}.jpg';
      return storage.ref(ref).putFile(file);
    } on FirebaseException catch(e){
      throw Exception('Erro no upload: ${e.code}');
    }
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

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
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index){
          setState(() {
            _pageChanged = index;
          });
        },
        children: [
          // titulo e subtitulo
          Form(
            key: _formKey1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: AppSize.s48),
                Text(AppStrings.tituloDoArtigo, style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s30),),
                const SizedBox(height: AppSize.s48,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.s25),
                  child: TextFormField(
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    maxLines: null,
                    cursorColor: ColorManager.marrom,
                    controller: _tituloController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: AppStrings.titulo
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return ErrorStrings.tituloVazio;
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
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    maxLines: null,
                    cursorColor: ColorManager.marrom,
                    controller: _subTituloController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: AppStrings.subTitulo
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return ErrorStrings.subtituloVazio;
                      } else if(value.length < 10) {
                        return ErrorStrings.subtituloCurto;
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(height: AppSize.s48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _button(
                      toNext: true,
                      formKey: _formKey1
                    )
                  ],
                )
              ],
            ),
          ),


          // imagem principal
          Form(
            key: _formKey2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: AppSize.s48),
                Text(AppStrings.imagemPrincipalArtigo, style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s30),),
                const SizedBox(height: AppSize.s48,),
                Text('Recomenda-se uma imagem de 1200x626 px', style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s18),),
                const SizedBox(height: AppSize.s10,),
                Container(
                  margin: const EdgeInsets.only(right: AppMargin.m12, left: AppMargin.m12),
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorManager.preto,
                      width: 1.5
                    ),
                  ),
                  child: uploading ? const Center(
                    child: CircularProgressIndicator(color: ColorManager.marrom,),
                  ) : arquivo == null ? Center(child: Image.asset(AssetsManager.withoutImage),)
                      :
                    SizedBox(
                      width: double.infinity,
                      height: 180,
                      child: Image.network(arquivo, fit: BoxFit.cover, ),
                    ),
                ),
                const SizedBox(height: AppSize.s10,),
                GestureDetector(
                  onTap: pickAndUploadImage,
                  child: Container(
                    width: AppSize.s140,
                    height: AppSize.s60,
                    padding: const EdgeInsets.all(AppPadding.p16),
                    decoration: BoxDecoration(
                        color: ColorManager.marrom,
                        borderRadius: BorderRadius.circular(AppSize.s10)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: uploading ? [const CircularProgressIndicator(color: ColorManager.branco)]:[
                        Text('Upload', style: getAlexandriaStyle(color: ColorManager.branco, fontSize: AppSize.s16),),
                        const Icon(Icons.upload, color: ColorManager.branco,)
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSize.s48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _button(toNext: false),
                    _button(
                      toNext: true,
                    )
                  ],
                )
              ],
            ),
          ),


          // texto do artigo
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: _formKey3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: AppSize.s48),
                    Text(AppStrings.textoArtigo, style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s30),),
                    const SizedBox(height: AppSize.s48,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSize.s25),
                      child: TextFormField(
                        onTapOutside: (_) => FocusScope.of(context).unfocus(),
                        maxLines: null,
                        cursorColor: ColorManager.marrom,
                        controller: _textoController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: AppStrings.texto
                        ),
                        validator: (value){
                          if(value!.isEmpty || value.length < 2){
                            return ErrorStrings.textoCurto;
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: AppSize.s48),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _button(toNext: false),
                        _button(toNext: true, formKey: _formKey3)
                      ],
                    )
                  ],
                ),
              ),
            )
          ),


          // Pré-visualização
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(left: AppPadding.p10, right: AppPadding.p10),
              child: Observer(
                builder: (_){
                  return Column(
                    children: [
                      const SizedBox(height: AppSize.s48),
                      Text(AppStrings.preView, style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s30),),
                      const SizedBox(height: AppSize.s48),

                      // Pré-visualização de fato
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s18),
                          border: Border.all(
                              color: ColorManager.preto,
                              width: 1.5
                          ),
                        ),
                        padding: const EdgeInsets.all(AppPadding.p5),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(AppSize.s18),
                                color: Colors.black,
                              ),
                              height: 160,
                              width: double.infinity,
                              child: arquivo == null ? Image.asset(AssetsManager.withoutImage, fit: BoxFit.cover,) :
                              SizedBox(
                                width: double.infinity,
                                height: 180,
                                child: Image.network(arquivo, fit: BoxFit.cover, ),
                              ),
                            ),
                            const SizedBox(height: AppSize.s18,),
                            Text(_tituloController.text, style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s25), textAlign: TextAlign.start,),
                            const SizedBox(height: AppSize.s18,),
                            Text(_subTituloController.text, style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s18), textAlign: TextAlign.start,),
                            const SizedBox(height: AppSize.s18,),
                            Text(_textoController.text, style: getAlexandriaStyle(color: ColorManager.preto, fontSize: AppSize.s12), textAlign: TextAlign.start,),
                            const SizedBox(height: AppSize.s20,),
                            Text('Por ${_viewModel.dadosUsuario[0].nome}', style: getAlexandriaStyle(color: ColorManager.marrom, fontSize: AppSize.s12), textAlign: TextAlign.start,),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSize.s48),
                      Text(AppStrings.algoErradoArtigo, style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s18), textAlign: TextAlign.center,),
                      const SizedBox(height: AppSize.s48),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _button(toNext: false),
                          _button(toNext: true)
                        ],
                      )
                    ],
                  );
                },
              )
            ),
          )
        ],
      ),
    );
  }


  /// Método responsável por implementar o botão de *próximo* ou *anterior*, a depender do parâmentro **toNext**.
  ///
  /// Exemplo de uso:
  ///
  ///  - Se o parâmetro **toNext** for **True** , o botão será setado como *próximo* e executará sua respectiva função.
  ///
  ///  - Se o parâmetro **toNext** for **False** , o botão será setado como *anterior* e executará sua respectiva função.
  ///
  /// Observação:
  ///
  /// É possível setar a **formKey**. Sua função é indicar a chave global, para que seja possível verificar e validar os campos daquela respectiva chave.
  Widget _button({required bool toNext, GlobalKey<FormState>? formKey}){
    _toNext(){
      if(_pageChanged==3){
        _pageController.animateToPage(
          3,
          duration: Duration(milliseconds: AppSize.s250.toInt()),
          curve: Curves.easeInOut
        );
      } else {
        if(formKey!=null){
          if(formKey.currentState!.validate()){
            _pageController.animateToPage(
              ++_pageChanged,
              duration: Duration(milliseconds: AppSize.s250.toInt()),
              curve: Curves.easeInOut
            );
          }
        }else{
          _pageController.animateToPage(
            ++_pageChanged,
            duration: Duration(milliseconds: AppSize.s250.toInt()),
            curve: Curves.easeInOut
          );
        }
      }
    }
    _toBack(){
      if(_pageChanged==0){
        _pageController.animateToPage(
          0,
          duration: Duration(milliseconds: AppSize.s250.toInt()),
          curve: Curves.easeInOut
        );
      } else {
        _pageController.animateToPage(
          --_pageChanged,
          duration: Duration(milliseconds: AppSize.s250.toInt()),
          curve: Curves.easeInOut
        );
      }
    }
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p12),
      child: GestureDetector(
        onTap: () => toNext ? _toNext() : _toBack(),
        child: Container(
          width: AppSize.s140,
          height: AppSize.s60,
          padding: const EdgeInsets.all(AppPadding.p16),
          decoration: BoxDecoration(
              color: ColorManager.marrom,
              borderRadius: BorderRadius.circular(AppSize.s10)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: toNext ? [
              Text(AppStrings.next, style: getAlexandriaStyle(color: ColorManager.branco, fontSize: AppSize.s16),),
              const Icon(Icons.arrow_forward_ios_rounded, color: ColorManager.branco,)
            ] : [
              const Icon(Icons.arrow_back_ios_rounded, color: ColorManager.branco,),
              Text(AppStrings.back, style: getAlexandriaStyle(color: ColorManager.branco, fontSize: AppSize.s16),)
            ],
          ),
        ),
      ),
    );
  }

}

