import 'package:flutter/cupertino.dart';

class ConnectionNotifier extends InheritedNotifier<ValueNotifier<bool>>{
  ConnectionNotifier({
    super.key,
    required super.child,
    required super.notifier
  });

  static ValueNotifier<bool> of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<ConnectionNotifier>()!.notifier!;
  }

}