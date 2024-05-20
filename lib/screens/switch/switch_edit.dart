// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:app_atalaia/screens/success_screen.dart';
import 'package:app_atalaia/widgets/header.dart';
import 'package:app_atalaia/widgets/menu.dart';
import 'package:flutter/material.dart';
import '../../widgets/build_input.dart';
import '../../widgets/button_icon.dart';
import '../error_screen.dart';
import 'switch_controller.dart';
import 'switch_model.dart';

class EditSwitchScreen extends StatefulWidget {
  final SwitchModel switchModel;

  const EditSwitchScreen({super.key, required this.switchModel});

  @override
  _EditSwitchScreenState createState() => _EditSwitchScreenState();
}

class _EditSwitchScreenState extends State<EditSwitchScreen> {
  late TextEditingController _nameController;
  TextEditingController? _wattsController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.switchModel.name);
    _wattsController ??=
        TextEditingController(text: widget.switchModel.watts.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _wattsController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(title: 'Editar Ponto'),
      endDrawer: const MenuDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BuildInput(
              labelText: 'Novo Nome do Ponto',
              controller: _nameController,
              icon: const Icon(Icons.edit),
            ),
            const SizedBox(height: 20),
            BuildInput(
              labelText: 'Novos Watts',
              controller: _wattsController ?? TextEditingController(),
              icon: const Icon(Icons.electrical_services),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ButtonIcon(
              labelText: 'Salvar',
              onPressed: () async {
                String newName = _nameController.text.trim();
                String newWatts = _wattsController?.text.trim() ?? '';
                if (newName.isNotEmpty) {
                  try {
                    // Atualizar o nome do switchModel
                    SwitchModel updatedSwitchModel = SwitchModel(
                      id: widget.switchModel.id,
                      uuid: widget.switchModel.uuid,
                      userId: widget.switchModel.userId,
                      iconName: widget.switchModel.iconName,
                      groupId: widget.switchModel.groupId,
                      macAddress: widget.switchModel.macAddress,
                      name: newName,
                      isActive: widget.switchModel.isActive,
                      lastTimeActive: widget.switchModel.lastTimeActive,
                      watts: newWatts.isNotEmpty
                          ? int.parse(newWatts)
                          : widget.switchModel.watts,
                      keepActive: widget.switchModel.keepActive,
                      scheduleActive: widget.switchModel.scheduleActive,
                      scheduleLastActivation:
                          widget.switchModel.scheduleLastActivation,
                      scheduleStart: widget.switchModel.scheduleStart,
                      scheduleEnd: widget.switchModel.scheduleEnd,
                      createdAt: widget.switchModel.createdAt,
                      updatedAt: widget.switchModel.updatedAt,
                      deletedAt: widget.switchModel.deletedAt,
                      guardActive: widget.switchModel.guardActive,
                    );

                    // Preparar os dados para atualizar o switch
                    Map<String, dynamic> updateData = {
                      'name': updatedSwitchModel.name,
                      'watts': updatedSwitchModel.watts,
                      'mac_address': updatedSwitchModel.macAddress,
                      'user_id': updatedSwitchModel.userId,
                    };

                    // Atualizar o switch
                    bool success =
                        await SwitchController().updateSwitch(updateData);

                    if (success) {
                      // Atualização bem-sucedida
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SuccessScreen(
                            message: 'Ponto Editado',
                            screen: '/switch',
                          ),
                        ),
                      );
                    } else {
                      // Exibir tela de erro se a atualização falhar
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
                    // Exibir tela de erro se ocorrer uma exceção
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
                  // Exibir mensagem de erro se o nome estiver vazio
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Por favor, insira um nome válido para o ponto.'),
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
