import 'package:flutter/material.dart';

class TopicosPage extends StatefulWidget {
  const TopicosPage({super.key});

  @override
  State<TopicosPage> createState() => _TopicosPageState();
}

class _TopicosPageState extends State<TopicosPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Tópicos')
      ],
    );
  }
}

