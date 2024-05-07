import 'package:flutter/material.dart';
import '../../widgets/menu.dart';
import '../../widgets/build_input.dart';
import '../../widgets/button_icon.dart';
import '../../widgets/header.dart';
import 'switch_controller.dart';

class SwitchCreateScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController macController = TextEditingController();
  final TextEditingController wattsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(title: 'Adicionar Ponto'),
      endDrawer: const MenuDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
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
            const SizedBox(height: 20),
            ButtonIcon(
              labelText: 'Adicionar',
              onPressed: () async {
                // Extrair os valores dos controllers
                String name = nameController.text;
                String macAddress = macController.text;
                String watts = wattsController.text;

                // Chamar a função na controller para criar um novo ponto
                bool success = await SwitchController.createSwitch(
                  name: name,
                  macAddress: macAddress,
                  watts: watts,
                );

                // Exibir uma mensagem de acordo com o resultado
                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Ponto adicionado com sucesso'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Falha ao adicionar ponto'),
                      backgroundColor: Colors.red,
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
