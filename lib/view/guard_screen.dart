import 'package:flutter/material.dart';

import '../screens/switch/switch_card_model.dart';
import '../widgets/header.dart';
import '../widgets/menu.dart';

class GuardManagementScreen extends StatelessWidget {
  final List<SwitchCardModel> guardSwitches = [
    SwitchCardModel(name: 'Switch 1', isActive: true),
    SwitchCardModel(name: 'Switch 2', isActive: false),
    SwitchCardModel(name: 'Switch 3', isActive: true),
  ];

  GuardManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(title: 'Gerenciamento da Guarda'),
      endDrawer: const MenuDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: guardSwitches.length,
          itemBuilder: (context, index) {
            final switchModel = guardSwitches[index];
            return Card(
              color: switchModel.isActive
                  ? Theme.of(context).colorScheme.onSecondary
                  : Theme.of(context).colorScheme.primary,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        switchModel.name,
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.background,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Icon(
                      switchModel.isActive
                          ? Icons.lightbulb
                          : Icons.lightbulb_outline,
                      color: switchModel.isActive ? Colors.yellow : Colors.grey,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
