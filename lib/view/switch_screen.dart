// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/auth_provider.dart';
import '../widgets/button_icon.dart';
import '../widgets/header.dart';
import '../widgets/menu.dart';
import '../widgets/switch_content.dart';
import '../controller/switch_controller.dart';
import 'switch_create_screen.dart';
import '../model/switch_model.dart';

class SwitchScreen extends StatefulWidget {
  const SwitchScreen({super.key});

  @override
  _SwitchScreenState createState() => _SwitchScreenState();
}

class _SwitchScreenState extends State<SwitchScreen> {
  late Future<List<SwitchModel>> _switchesFuture;

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userId = authProvider.userId;
    if (userId != null) {
      _switchesFuture = SwitchController().getSwitches();
    } else {
      _switchesFuture = Future.error('User ID is null');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userId = authProvider.userId;

    if (userId == null) {
      return const Scaffold(
        body: Center(
          child: Text('Erro: usuário não autenticado'),
        ),
      );
    }

    return Scaffold(
      appBar: const Header(title: 'Gerenciar Pontos'),
      endDrawer: const MenuDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: SwitchContent(
                selectedIndex: 1,
                switchesFuture: _switchesFuture,
                isDeleting: true,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              setState(() {
                _switchesFuture = SwitchController().getSwitches();
              });
            },
            icon: const Icon(Icons.refresh),
            backgroundColor: Theme.of(context).colorScheme.onSecondary,
          ),
        ],
      ),
    );
  }
}
