import 'package:flutter/material.dart';

import '../../widgets/build_input.dart';
import '../../widgets/button_icon.dart';
import '../../widgets/header.dart';
import 'switch_controller.dart';

class SwitchEditScreen extends StatefulWidget {
  final String macAddress;

  SwitchEditScreen({required this.macAddress});

  @override
  _SwitchEditScreenState createState() => _SwitchEditScreenState();
}

class _SwitchEditScreenState extends State<SwitchEditScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController wattsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Aqui você pode carregar os detalhes do switch com base no endereço MAC
    // usando o método getSwitch do seu SwitchController
    loadSwitchDetails();
  }

  void loadSwitchDetails() async {
    try {
      Map<String, dynamic>? switchData =
          await SwitchController.getSwitch(widget.macAddress);
      if (switchData != null) {
        setState(() {
          nameController.text = switchData['name'];
          wattsController.text = switchData['watts'].toString();
        });
      }
    } catch (e) {
      print('Error loading switch details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: 'Editar Switch'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BuildInput(
              labelText: 'Nome',
              controller: nameController,
            ),
            BuildInput(
              labelText: 'Watts',
              controller: wattsController,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ButtonIcon(
              labelText: 'Salvar Alterações',
              onPressed: () {
                // Aqui você pode obter os novos valores dos campos
                final String name = nameController.text;
                final double watts =
                    double.tryParse(wattsController.text) ?? 0.0;

                // Em seguida, você pode chamar o método updateSwitch do seu SwitchController
                updateSwitch(name, watts);
              },
              backgroundColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  void updateSwitch(String name, double watts) async {
    try {
      // Aqui você pode chamar o método updateSwitch do seu SwitchController
      await SwitchController.updateSwitch({
        'mac_address': widget.macAddress,
        'name': name,
        'watts': watts,
      });
      // Após a atualização bem-sucedida, você pode exibir uma mensagem ou navegar de volta
      // para a tela anterior, dependendo da sua lógica de navegação
    } catch (e) {
      print('Error updating switch: $e');
    }
  }
}
