// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/auth_provider.dart';
import '../../utils/utils.dart';
import 'switch_model.dart';
import 'switch_controller.dart';

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
    isActive = widget.switchModel.isActive;
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
      color: Theme.of(context).colorScheme.onSecondary,
      elevation: 3,
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
              onTap: () async {
                print(
                    'Toggling switch with MAC address: ${widget.switchModel.macAddress}');
                bool success = await switchController.toggleSwitch(
                  widget.switchModel.macAddress,
                  !isActive,
                  userId,
                );
                if (success) {
                  print('Toggle successful, updating state.');
                  setState(() {
                    isActive = !isActive;
                  });
                } else {
                  print('Toggle failed.');
                }
              },
              child: Icon(
                Icons.lightbulb,
                size: 40,
                color: isActive ? Colors.yellow : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
