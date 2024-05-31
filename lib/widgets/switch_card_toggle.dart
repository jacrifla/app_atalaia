import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constantes.dart';
import '../utils/auth_provider.dart';
import '../utils/utils.dart';
import '../model/switch_model.dart';
import '../controller/switch_controller.dart';

class SwitchCard extends StatefulWidget {
  final SwitchModel switchModel;

  const SwitchCard({super.key, required this.switchModel});

  @override
  _SwitchCardState createState() => _SwitchCardState();
}

class _SwitchCardState extends State<SwitchCard> {
  bool isActive = false;

  @override
  void initState() {
    super.initState();
    isActive = widget.switchModel.isActive ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final switchController = Provider.of<SwitchController>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final userId = authProvider.userId;

    if (userId == null) {
      return const Text('User not authenticated');
    }

    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              toCapitalizeWords(widget.switchModel.name ?? 'Unknown'),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.background,
              ),
            ),
            GestureDetector(
              onTap: () async {
                print(
                    'Alternando switch com o MAC address: ${widget.switchModel.macAddress ?? ''}');
                bool success = await switchController.toggleSwitch(
                  widget.switchModel.macAddress ?? '',
                  !isActive,
                  userId,
                );
                if (success) {
                  print('Alternância bem-sucedida, atualizando estado.');
                  setState(() {
                    isActive = !isActive;
                  });
                } else {
                  print('Alternância falhou.');
                }
              },
              child: Icon(
                Icons.lightbulb,
                size: 40,
                color: isActive ? activeColor : inactiveColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
