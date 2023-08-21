// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conta_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ContaViewModel on ContaViewModelMobx, Store {
  Computed<List<Usuario>>? _$dadosUsuarioComputed;

  @override
  List<Usuario> get dadosUsuario => (_$dadosUsuarioComputed ??=
          Computed<List<Usuario>>(() => super.dadosUsuario,
              name: 'ContaViewModelMobx.dadosUsuario'))
      .value;

  late final _$_infoUserAtom =
      Atom(name: 'ContaViewModelMobx._infoUser', context: context);

  @override
  List<Usuario> get _infoUser {
    _$_infoUserAtom.reportRead();
    return super._infoUser;
  }

  @override
  set _infoUser(List<Usuario> value) {
    _$_infoUserAtom.reportWrite(value, super._infoUser, () {
      super._infoUser = value;
    });
  }

  late final _$acessarDadosAsyncAction =
      AsyncAction('ContaViewModelMobx.acessarDados', context: context);

  @override
  Future acessarDados(String tipo, BuildContext context) {
    return _$acessarDadosAsyncAction
        .run(() => super.acessarDados(tipo, context));
  }

  late final _$salvarDadosAsyncAction =
      AsyncAction('ContaViewModelMobx.salvarDados', context: context);

  @override
  Future salvarDados(String tipo, BuildContext context,
      {String? nome, dynamic sobre}) {
    return _$salvarDadosAsyncAction
        .run(() => super.salvarDados(tipo, context, nome: nome, sobre: sobre));
  }

  @override
  String toString() {
    return '''
dadosUsuario: ${dadosUsuario}
    ''';
  }
}
