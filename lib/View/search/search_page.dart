import 'package:app_blog/View/resources/color_manager.dart';
import 'package:app_blog/View/resources/strings_manager.dart';
import 'package:app_blog/View/resources/style_manager.dart';
import 'package:app_blog/View/resources/values_manager.dart';
import 'package:app_blog/ViewModel/search/search_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../Model/models/Artigo.dart';
import '../common/card_artigo.dart';
import '../resources/routes_manager.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  
  final SearchViewModel _viewModel = SearchViewModel();

  _bind()async{
    await _viewModel.recuperarDados(context);
    await _viewModel.recuperarTopicos(context);
  }

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
        body: Observer(
          builder: (_){
            if(_viewModel.artigos.isEmpty){
              return const Center(child: CircularProgressIndicator(
                color: ColorManager.marrom,
              ),);
            } else {
              return RefreshIndicator(
                backgroundColor: ColorManager.marrom,
                color: ColorManager.branco,
                onRefresh: () => _bind(),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // Barra de pesquisa
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppPadding.p16),
                        child: TextField(
                          onChanged: _viewModel.setFilter,
                          cursorColor: ColorManager.marrom,
                          decoration: InputDecoration(
                              hintText: AppStrings.pesquisar,
                              hintStyle: getAlexandriaStyle(color: ColorManager.cinza),
                              prefixIcon: const Icon(Icons.search_rounded, color:ColorManager.preto, size: AppSize.s30,),
                          ),
                          textInputAction: TextInputAction.search,
                          keyboardType: TextInputType.text,
                          style: getAlexandriaStyle(color: ColorManager.preto, fontSize: AppSize.s16),
                          onTapOutside: (_) => FocusScope.of(context).unfocus(),
                        ),
                      ),

                      // opções de filtros
                      Container(
                        width: double.infinity,
                        height: AppSize.s80,
                        padding: const EdgeInsets.only(top: AppPadding.p5, bottom: AppPadding.p5, left: AppPadding.p20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () => _modal(),
                              child: Container(
                                width: AppSize.s130,
                                height: AppSize.s60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(AppSize.s20),
                                    border: Border.all(
                                      color: ColorManager.preto,
                                    )
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Icon(Icons.filter_list_rounded, color: ColorManager.preto,),
                                    Text(AppStrings.filtrar, style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s16),)
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      // resultado da pesquisa
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height*0.58,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: _viewModel.listFiltered.length,
                            itemBuilder: (_,i){
                              Artigo artigo = _viewModel.listFiltered[i];
                              return GestureDetector(
                                onTap: ()=>Navigator.pushNamed(context, Routes.leituraPage, arguments: artigo),
                                child: CardArtigo(artigo),
                              );
                            }
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Future _modal(){
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(AppSize.s25),
          topLeft: Radius.circular(AppSize.s25)
        )
      ),
      backgroundColor: ColorManager.cinza,
      context: context,
      showDragHandle: true,
      builder: (context){
        return Container(
          decoration: const BoxDecoration(
            color: ColorManager.branco,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(AppSize.s25),
              topLeft: Radius.circular(AppSize.s25)
            )
          ),
          height: AppSize.s580,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 50,
                padding: const EdgeInsets.all(AppPadding.p10),
                color: ColorManager.cinza,
                child: Center(
                  child: Text('Filtrar por Tópicos', style: getAlexandriaStyle(color: ColorManager.branco, fontSize: AppSize.s18),
                    textAlign: TextAlign.center,),
                ),
              ),
              Observer(
                builder: (_){
                  return Container(
                    height: 370,
                    color: ColorManager.branco,
                    child: ListView.builder(
                      itemCount: _viewModel.topicos.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (_,i){
                        return GestureDetector(
                          onTap: (){},
                          child: Text(_viewModel.topicos[i], style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s16),),
                        );
                      },
                    ),
                  );
                },
              )
            ],
          ),
        );
      }
    );
  }

  Widget _topico(){
    // TODO: implementar pesquisa dos tópicos
    return Container();
  }

}

