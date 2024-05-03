import 'package:app_atalaia/widgets/header.dart';
import 'package:flutter/material.dart';

class SwitchPage extends StatefulWidget {
  const SwitchPage({super.key});

  @override
  State<SwitchPage> createState() => _SwitchPageState();
}

class _SwitchPageState extends State<SwitchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: 'Pontos'),
      body: Center(
        child: Text('Pontos'),
      ),
    );
  }
}
