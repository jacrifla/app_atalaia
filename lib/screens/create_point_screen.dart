// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../widgets/button_icon.dart';
import '../widgets/build_input.dart';
import '../widgets/header.dart';
import '../widgets/menu.dart';

class CreatePointScreen extends StatefulWidget {
  const CreatePointScreen({super.key});

  @override
  State<CreatePointScreen> createState() => _CreatePointScreenState();
}

class _CreatePointScreenState extends State<CreatePointScreen> {
  bool isConnected = false;
  bool keepActive = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController macController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: 'Criar Ponto'),
      endDrawer: MenuDrawer(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BuildInput(
              labelText: 'Nome do Ponto',
              controller: nameController,
            ),
            Text('Escreva'),
            BuildInput(
              labelText: 'MAC Address',
              hintText: 'A8:E3:EE:BA:AD:21',
              controller: macController,
              icon: Icon(Icons.network_ping),
            ),
            BuildInput(
              labelText: 'MAC Address',
              hintText: 'A8:E3:EE:BA:AD:21',
              controller: macController,
              icon: Icon(Icons.flash_on),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonIcon(
                  icon: Icon(Icons.check),
                  onPressed: saveInfo,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void saveInfo() {
    // Lógica para salvar o ponto aqui
  }
}
