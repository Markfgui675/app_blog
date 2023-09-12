// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SearchViewModel on SearchViewModelMobx, Store {
  Computed<List<Artigo>>? _$artigosComputed;

  @override
  List<Artigo> get artigos =>
      (_$artigosComputed ??= Computed<List<Artigo>>(() => super.artigos,
              name: 'SearchViewModelMobx.artigos'))
          .value;
  Computed<List<String>>? _$topicosComputed;

  @override
  List<String> get topicos =>
      (_$topicosComputed ??= Computed<List<String>>(() => super.topicos,
              name: 'SearchViewModelMobx.topicos'))
          .value;

  late final _$_artigosAtom =
      Atom(name: 'SearchViewModelMobx._artigos', context: context);

  @override
  List<Artigo> get _artigos {
    _$_artigosAtom.reportRead();
    return super._artigos;
  }

  @override
  set _artigos(List<Artigo> value) {
    _$_artigosAtom.reportWrite(value, super._artigos, () {
      super._artigos = value;
    });
  }

  late final _$_topicosAtom =
      Atom(name: 'SearchViewModelMobx._topicos', context: context);

  @override
  List<String> get _topicos {
    _$_topicosAtom.reportRead();
    return super._topicos;
  }

  @override
  set _topicos(List<String> value) {
    _$_topicosAtom.reportWrite(value, super._topicos, () {
      super._topicos = value;
    });
  }

  late final _$recuperarDadosAsyncAction =
      AsyncAction('SearchViewModelMobx.recuperarDados', context: context);

  @override
  Future recuperarDados(BuildContext context) {
    return _$recuperarDadosAsyncAction.run(() => super.recuperarDados(context));
  }

  late final _$recuperarTopicosAsyncAction =
      AsyncAction('SearchViewModelMobx.recuperarTopicos', context: context);

  @override
  Future recuperarTopicos(BuildContext context) {
    return _$recuperarTopicosAsyncAction
        .run(() => super.recuperarTopicos(context));
  }

  @override
  String toString() {
    return '''
artigos: ${artigos},
topicos: ${topicos}
    ''';
  }
}
