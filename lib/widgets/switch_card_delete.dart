import 'package:app_atalaia/utils/routes.dart';
import 'package:flutter/material.dart';
import '../provider/switch_provider.dart';
import '../themes/theme.dart';
import '../utils/utils.dart';
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
  State<SwitchCardDelete> createState() => _SwitchCardDeleteState();
}

class _SwitchCardDeleteState extends State<SwitchCardDelete> {
  final SwitchProvider switchProvider = SwitchProvider();
  late final SwitchController ctlSwitchController;

  @override
  void initState() {
    super.initState();
    ctlSwitchController = SwitchController(provider: switchProvider);
  }

  Future<void> _confirmDelete() async {
    final confirmed = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmationScreen(
          question: 'Tem certeza que deseja excluir este ponto?',
          onConfirm: () {
            Navigator.pop(context, true);
          },
          onCancel: () {
            Navigator.pop(context, false);
          },
        ),
      ),
    );

    if (confirmed == true) {
      await _handleDelete();
    }
  }

  Future<void> _handleDelete() async {
    bool success = await ctlSwitchController.deleteSwitch(
      macAddress: widget.switchModel.macAddress!,
    );
    if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SuccessScreen(
            message: 'Ponto excluído com sucesso!',
            screen: AppRoutes.switchScreen,
          ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ErrorScreen(
            message: 'Erro ao excluir o ponto.',
            errorDescription:
                'Não foi possível excluir o ponto. Por favor, tente novamente.',
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
                toCapitalizeWords(widget.switchModel.name!),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: appTheme.colorScheme.background,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _confirmDelete();
                },
                child: Icon(
                  Icons.close,
                  size: 40,
                  color: appTheme.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
