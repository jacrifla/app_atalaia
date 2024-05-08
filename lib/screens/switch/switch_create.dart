import 'package:flutter/material.dart';

import '../../widgets/menu.dart';
import '../../widgets/build_input.dart';
import '../../widgets/button_icon.dart';
import '../../widgets/header.dart';
// import '../error_screen.dart';
import '../success_screen.dart';

class SwitchCreateScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController macController = TextEditingController();
  final TextEditingController wattsController = TextEditingController();

  SwitchCreateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: 'Adicionar Ponto'),
      endDrawer: MenuDrawer(),
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
            ButtonIcon(
              labelText: 'Adicionar',
              onPressed: () {
                // String name = nameController.text;
                // String macAddress = macController.text;
                // int watts = int.tryParse(wattsController.text) ?? 0;

                // Simulação de sucesso
                bool success = true;

                if (success) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SuccessScreen(
                        message: 'Ponto adicionado com sucesso',
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
