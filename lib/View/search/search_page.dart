import 'package:app_blog/View/resources/color_manager.dart';
import 'package:app_blog/View/resources/strings_manager.dart';
import 'package:app_blog/View/resources/style_manager.dart';
import 'package:app_blog/View/resources/values_manager.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  
  final TextEditingController _pesquisa = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.branco,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                padding: const EdgeInsets.all(AppPadding.p16),
                child: TextField(
                  cursorColor: ColorManager.marrom,
                  decoration: InputDecoration(
                    hintText: AppStrings.pesquisar,
                    hintStyle: getAlexandriaStyle(color: ColorManager.cinza),
                    prefixIcon: const Icon(Icons.search_rounded, color:ColorManager.preto, size: AppSize.s30,),
                    suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          _pesquisa.text = '';
                        });
                      },
                      icon: const Icon(Icons.highlight_remove_rounded, color: ColorManager.marrom, size: AppSize.s25,),
                    )
                  ),
                  textInputAction: TextInputAction.search,
                  onSubmitted: (palavra){
                    print(palavra);
                  },
                  controller: _pesquisa,
                  keyboardType: TextInputType.text,
                  style: getAlexandriaStyle(color: ColorManager.preto, fontSize: AppSize.s16),
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

