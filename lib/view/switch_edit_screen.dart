import 'package:flutter/material.dart';
import 'package:app_atalaia/view/success_screen.dart';
import 'package:app_atalaia/widgets/header.dart';
import 'package:app_atalaia/widgets/menu.dart';
import '../widgets/build_input.dart';
import '../widgets/button_icon.dart';
import 'error_screen.dart';
import '../controller/switch_controller.dart';
import '../model/switch_model.dart';

class EditSwitchScreen extends StatefulWidget {
  final SwitchModel switchModel;

  const EditSwitchScreen({super.key, required this.switchModel});

  @override
  _EditSwitchScreenState createState() => _EditSwitchScreenState();
}

class _EditSwitchScreenState extends State<EditSwitchScreen> {
  late TextEditingController _nameController;
  late TextEditingController _wattsController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.switchModel.name);
    _wattsController =
        TextEditingController(text: widget.switchModel.watts?.toString() ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _wattsController.dispose();
    super.dispose();
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
              ButtonIcon(
                labelText: 'Salvar',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    String newName = _nameController.text.trim();
                    String newWatts = _wattsController.text.trim();
                    try {
                      SwitchModel updatedSwitchModel = SwitchModel(
                        uuid: widget.switchModel.uuid,
                        userId: widget.switchModel.userId,
                        groupId: widget.switchModel.groupId,
                        macAddress: widget.switchModel.macAddress,
                        name: newName,
                        isActive: widget.switchModel.isActive,
                        watts: int.tryParse(newWatts),
                        guardActive: widget.switchModel.guardActive,
                      );

                      Map<String, dynamic> updateData =
                          updatedSwitchModel.toJson();

                      bool success =
                          await SwitchController().updateSwitch(updateData);

                      if (success) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SuccessScreen(
                              message: 'Ponto Editado',
                              screen: '/switch',
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
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Por favor, insira valores válidos.'),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
