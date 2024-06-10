import 'package:flutter/material.dart';
import '../provider/switch_provider.dart';
import '../themes/theme.dart';
import '../utils/utils.dart';
import '../model/switch_model.dart';
import '../controller/switch_controller.dart';
import '../view/switch_edit_screen.dart';

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
    bool confirmed = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tem certeza que deseja excluir este ponto?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Sim'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Não'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await _handleDelete();
    }
  }

  Future<void> _handleDelete() async {
    bool success = await ctlSwitchController.deleteSwitch(
      macAddress: widget.switchModel.macAddress!,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success
              ? 'Ponto excluído com sucesso!'
              : 'Erro ao excluir o ponto. Não foi possível excluir o ponto. Por favor, tente novamente.',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );
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
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                toCapitalizeWords(widget.switchModel.name!),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: appTheme.primaryColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _confirmDelete();
                },
                child: Icon(
                  Icons.delete,
                  size: 25,
                  color: appTheme.colorScheme.error,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
