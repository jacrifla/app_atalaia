// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

import '../widgets/header.dart';
import '../widgets/menu.dart';

class SwitchPage extends StatefulWidget {
  const SwitchPage({super.key});

  @override
  State<SwitchPage> createState() => _SwitchPageState();
}

class _SwitchPageState extends State<SwitchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: Header(title: 'Pontos'),
      body: Center(
        child: Text('Pontos'),
      ),
    );
  }
}
