import 'package:flutter/material.dart';

import '../resources/color_manager.dart';

class SalvoPage extends StatefulWidget {
  const SalvoPage({super.key});

  @override
  State<SalvoPage> createState() => _SalvoPageState();
}

class _SalvoPageState extends State<SalvoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.branco,
        body: const Center(
          child: Text('Salvos'),
        )
    );
  }
}

