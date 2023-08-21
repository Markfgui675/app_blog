import 'package:app_blog/Model/models/TipoAcessoDataBase.dart';
import 'package:app_blog/ViewModel/conta/conta_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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

  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

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
          Container(
            child: Form(
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
          ),


          // texto do artigo
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: _formKey2,
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
                        _button(toNext: true)
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
  
  Widget _button({required bool toNext, GlobalKey<FormState>? formKey}){
    _toNext(){
      if(_pageChanged==2){
        _pageController.animateToPage(
          2,
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

