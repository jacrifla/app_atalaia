import 'package:flutter/material.dart';

import '../../widgets/button_icon.dart';
import '../../widgets/header.dart';
import '../../widgets/menu.dart';
import 'switch_create.dart';

class SwitchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: 'Pontos'),
      endDrawer: MenuDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Seu conteúdo aqui...
          ],
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
              icon: Icon(Icons.add),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          ),
          ButtonIcon(
            labelText: 'Atualizar Pontos',
            onPressed: () {
              // Lógica para atualizar os pontos
              // Chame uma função para buscar os pontos do banco de dados ou algo similar
              // Atualize o estado ou os dados conforme necessário
            },
            icon: Icon(Icons.refresh),
            backgroundColor: Theme.of(context).colorScheme.onSecondary,
          ),
        ],
      ),
    );
  }
}
