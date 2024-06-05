import 'package:flutter/material.dart';
import 'error_screen.dart';
import '../provider/switch_provider.dart';
import '../controller/switch_controller.dart';
import '../utils/routes.dart';
import '../view/success_screen.dart';
import '../model/switch_model.dart';
import '../widgets/header.dart';
import '../widgets/menu.dart';
import '../widgets/build_input.dart';
import '../widgets/button_icon.dart';

class EditSwitchScreen extends StatefulWidget {
  final SwitchModel switchModel;

  const EditSwitchScreen({super.key, required this.switchModel});

  @override
  State<EditSwitchScreen> createState() => _EditSwitchScreenState();
}

class _EditSwitchScreenState extends State<EditSwitchScreen> {
  late final SwitchController ctlSwitchController;
  late TextEditingController _nameController;
  late TextEditingController _wattsController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    ctlSwitchController = SwitchController(SwitchProvider());
    _nameController = TextEditingController(text: widget.switchModel.name);
    _wattsController =
        TextEditingController(text: widget.switchModel.watts?.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _wattsController.dispose();
    super.dispose();
  }

  Future<void> _updateSwitch() async {
    if (_formKey.currentState!.validate()) {
      String newName = _nameController.text.trim().toLowerCase();
      String newWatts = _wattsController.text.trim();
      try {
        bool success = await ctlSwitchController.updateSwitch(
          name: newName,
          watts: newWatts,
          macAddress: widget.switchModel.macAddress!,
        );

        if (success) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SuccessScreen(
                message: 'Ponto Editado',
                screen: AppRoutes.switchScreen,
              ),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const ErrorScreen(
                message: 'Falha ao atualizar o switch.',
                errorDescription: 'Tente novamente mais tarde.',
              ),
            ),
          );
        }
      } catch (error) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ErrorScreen(
              message: 'Ocorreu um erro.',
              errorDescription: error.toString(),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(title: 'Editar Ponto'),
      endDrawer: const MenuDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BuildInput(
                labelText: 'Nome do Ponto',
                controller: _nameController,
                icon: const Icon(Icons.edit),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um nome';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              BuildInput(
                labelText: 'Novos Watts',
                controller: _wattsController,
                icon: const Icon(Icons.electrical_services),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um valor de watts';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 300,
        child: ButtonIcon(
          labelText: 'Salvar',
          onPressed: _updateSwitch,
          icon: const Icon(Icons.save),
        ),
      ),
    );
  }
}
