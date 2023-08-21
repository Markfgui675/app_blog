import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
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

  PageController _pageController = PageController(
    initialPage: 0
  );
  int _pageChanged = 0;

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
                  const Spacer(),
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
                  const Spacer(),
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
          Container(
              height: MediaQuery.of(context).size.height,
              child: Form(
                key: _formKey2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
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
                            labelText: AppStrings.titulo
                        ),
                        validator: (value){
                          if(value!.isEmpty || value.length < 10){
                            return ErrorStrings.tituloVazio;
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _button(toNext: false),
                        _button(toNext: true)
                      ],
                    )
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
  
  Widget _button({required bool toNext, GlobalKey<FormState>? formKey}){
    _toNext(){
      if(_pageChanged==1){
        _pageController.animateToPage(
          1,
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

