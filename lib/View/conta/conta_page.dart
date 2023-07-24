import 'package:flutter/material.dart';

import '../resources/color_manager.dart';

class ContaPage extends StatefulWidget {
  const ContaPage({super.key});

  @override
  State<ContaPage> createState() => _ContaPageState();
}

class _ContaPageState extends State<ContaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.branco,
        body: const Center(
        child: Text('Conta'),
      )
    );
  }
}

