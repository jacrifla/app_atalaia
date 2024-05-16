import 'package:app_atalaia/utils/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/menu.dart';
import '../../widgets/build_input.dart';
import '../../widgets/button_icon.dart';
import '../../widgets/header.dart';

import '../error_screen.dart';
import '../success_screen.dart';
import 'switch_provider.dart';

class SwitchCreateScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController macController = TextEditingController();
  final TextEditingController wattsController = TextEditingController();

  SwitchCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final switchProvider = Provider.of<SwitchProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: const Header(title: 'Adicionar Ponto'),
      endDrawer: const MenuDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Nomeie o novo ponto e escolha entre os opções a seguir',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BuildInput(
                  labelText: 'Nome',
                  controller: nameController,
                  icon: const Icon(Icons.polyline),
                ),
                BuildInput(
                  labelText: 'Endereço MAC',
                  controller: macController,
                  icon: const Icon(Icons.network_ping),
                ),
                BuildInput(
                  labelText: 'Watts',
                  controller: wattsController,
                  keyboardType: TextInputType.number,
                  icon: const Icon(Icons.flash_on),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ButtonIcon(
            height: 50,
            icon: const Icon(Icons.add),
            labelText: 'Adicionar',
            onPressed: () async {
              final userId = authProvider.userId;
              print('USER SWITCH sim: $userId');
              if (userId != null) {
                await switchProvider.createSwitch(
                  nameController.text.toLowerCase(),
                  wattsController.text,
                  macController.text.toUpperCase(),
                  userId,
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SuccessScreen(
                      message: 'Ponto salvo com sucesso',
                      onOKPressed: () {
                        nameController.clear();
                        macController.clear();
                        wattsController.clear();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              } else {
                print('USER SWITCH nao: $userId');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ErrorScreen(
                      message: 'Erro',
                      errorDescription: 'Não foi possível salvar o ponto',
                      onOKPressed: () => Navigator.pop(context),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
