import 'package:flutter/material.dart';

import 'success_screen.dart';
import '../utils/routes.dart';
import '../utils/utils.dart';
import '../widgets/menu.dart';
import '../widgets/build_input.dart';
import '../widgets/button_icon.dart';
import '../widgets/header.dart';
import '../controller/switch_controller.dart';
import '../provider/switch_provider.dart';

class SwitchCreateScreen extends StatefulWidget {
  const SwitchCreateScreen({super.key});

  @override
  State<SwitchCreateScreen> createState() => _SwitchCreateScreenState();
}

class _SwitchCreateScreenState extends State<SwitchCreateScreen> {
  final SwitchProvider switchProvider = SwitchProvider();
  late final SwitchController ctlSwitchController;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController macController = TextEditingController();
  final TextEditingController wattsController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    ctlSwitchController = SwitchController(switchProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(title: 'Adicionar Ponto'),
      endDrawer: const MenuDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
              const SizedBox(height: 20),
              BuildInput(
                labelText: 'Nome',
                controller: nameController,
                icon: const Icon(Icons.polyline),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite o nome do ponto';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              BuildInput(
                labelText: 'Endereço MAC',
                controller: macController,
                icon: const Icon(Icons.network_ping),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite o endereco de MAC';
                  } else if (!isValidMacAddress(value)) {
                    return 'Formato de endereço MAC inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              BuildInput(
                labelText: 'Watts',
                controller: wattsController,
                keyboardType: TextInputType.number,
                icon: const Icon(Icons.flash_on),
                emptyFieldHandler: () => '0',
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ButtonIcon(
                  height: 50,
                  icon: const Icon(Icons.add),
                  labelText: 'Adicionar',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await ctlSwitchController.createSwitch(
                        nameController.text.toLowerCase(),
                        wattsController.text,
                        macController.text.toUpperCase(),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SuccessScreen(
                            message: 'Ponto salvo com sucesso',
                            screen: AppRoutes.successScreen,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
