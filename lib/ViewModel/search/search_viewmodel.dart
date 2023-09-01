// TODO: implementar arquivo mobx que recupera os artigos, usuários, tópicos e os aloca em uma lista que será pesquisada pela view



import 'package:mobx/mobx.dart';
part 'search_viewmodel.g.dart';

class SearchViewModel = SearchViewModelMobx with _$SearchViewModel;

abstract class SearchViewModelMobx with Store{

}
