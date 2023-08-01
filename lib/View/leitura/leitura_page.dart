import 'package:flutter/material.dart';

import '../../Model/models/Artigo.dart';

class LeituraPage extends StatelessWidget {
  Artigo artigo;

  LeituraPage(this.artigo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(artigo.titulo),
      ),
      body: Center(
        child: Column(
          children: [
            Text(artigo.subTitulo),
            Text(artigo.texto),
          ],
        ),
      ),
    );
  }
}

