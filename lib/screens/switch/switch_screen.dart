import 'package:flutter/material.dart';

import '../../widgets/button_icon.dart';
import '../../widgets/header.dart';
import '../../widgets/menu.dart';
import 'switch_create.dart';
import 'switch_model.dart'; // Importe o modelo SwitchModel

class SwitchScreen extends StatelessWidget {
  const SwitchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de pontos fictícios
    final List<SwitchModel> switches = [
      SwitchModel(
          name: 'Switch 1',
          macAddress: '00:11:22:33:44:55',
          watts: 100,
          isActive: true),
      SwitchModel(
          name: 'Switch 2',
          macAddress: '11:22:33:44:55:66',
          watts: 150,
          isActive: false),
      SwitchModel(
          name: 'Switch 3',
          macAddress: '22:33:44:55:66:77',
          watts: 200,
          isActive: true),
    ];

    return Scaffold(
      appBar: const Header(title: 'Pontos'),
      endDrawer: const MenuDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: switches.length,
          itemBuilder: (context, index) {
            final switchModel = switches[index];
            return Card(
              color: switchModel.isActive
                  ? Theme.of(context).colorScheme.onSecondary
                  : Theme.of(context).colorScheme.primary,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        switchModel.name,
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.background,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Exluir
                      },
                      child: const Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ButtonIcon(
              labelText: 'Adicionar Ponto',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SwitchCreateScreen()),
                );
              },
              icon: const Icon(Icons.add),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          ),
          ButtonIcon(
            labelText: 'Atualizar Pontos',
            onPressed: () {},
            icon: const Icon(Icons.refresh),
            backgroundColor: Theme.of(context).colorScheme.onSecondary,
          ),
        ],
      ),
    );
  }
}
