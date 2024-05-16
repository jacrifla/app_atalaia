import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/auth_provider.dart';
import '../../widgets/button_icon.dart';
import '../../widgets/header.dart';
import '../../widgets/menu.dart';
import '../../widgets/switch_card.dart';
import 'switch_controller.dart';
import 'switch_create.dart';
import 'switch_model.dart';

class SwitchScreen extends StatelessWidget {
  const SwitchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userId = authProvider.userId;

    return Scaffold(
      appBar: const Header(title: 'Pontos'),
      endDrawer: const MenuDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<SwitchModel>>(
                future: SwitchController().getSwitches(userId!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erro: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('Nenhum switch cadastrado'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return SwitchCard(switchModel: snapshot.data![index]);
                      },
                    );
                  }
                },
              ),
            ),
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
              icon: const Icon(Icons.add),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          ),
          ButtonIcon(
            labelText: 'Atualizar Pontos',
            onPressed: () {
              Provider.of<SwitchController>(context, listen: false)
                  .getSwitches(userId);
            },
            icon: const Icon(Icons.refresh),
            backgroundColor: Theme.of(context).colorScheme.onSecondary,
          ),
        ],
      ),
    );
  }
}
