// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:app_atalaia/utils/utils.dart';
import 'package:flutter/material.dart';
import '../view/confirmation_screen.dart';
import '../view/error_screen.dart';
import '../view/success_screen.dart';
import '../view/switch_edit_screen.dart';
import '../model/switch_model.dart';
import '../controller/switch_controller.dart';

class SwitchCardDelete extends StatefulWidget {
  final SwitchModel switchModel;

  const SwitchCardDelete({
    super.key,
    required this.switchModel,
  });

  @override
  _SwitchCardDeleteState createState() => _SwitchCardDeleteState();
}

class _SwitchCardDeleteState extends State<SwitchCardDelete> {
  Future<void> _confirmDelete(BuildContext context) async {
    final confirmed = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmationScreen(
          question: 'Tem certeza que deseja excluir este ponto?',
          onConfirm: () {
            _handleDelete();
          },
          onCancel: () {
            Navigator.pop(context);
          },
        ),
      ),
    );

    if (confirmed == true) {
      _handleDelete();
    }
  }

  Future<void> _handleDelete() async {
    SwitchController switchController = SwitchController();
    bool success =
        await switchController.deleteSwitch(widget.switchModel.macAddress);
    if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SuccessScreen(
            message: 'Switch excluído com sucesso!',
            screen: '/switch',
          ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ErrorScreen(
            message: 'Erro ao excluir o switch',
            errorDescription:
                'Não foi possível excluir o switch. Por favor, tente novamente.',
            onOKPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  EditSwitchScreen(switchModel: widget.switchModel),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                toCapitalizeWords(widget.switchModel.name),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _confirmDelete(context);
                },
                child: Icon(
                  Icons.close,
                  size: 40,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
