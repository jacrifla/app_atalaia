import 'package:flutter/material.dart';

import '../controller/guard_controller.dart';
import '../provider/guard_provider.dart';
import '../model/switch_card_model.dart';
import '../widgets/header.dart';
import '../widgets/menu.dart';

class GuardManagementScreen extends StatefulWidget {
  const GuardManagementScreen({super.key});

  @override
  State<GuardManagementScreen> createState() => _GuardManagementScreenState();
}

class _GuardManagementScreenState extends State<GuardManagementScreen> {
  final GuardManagementProvider guardProvider = GuardManagementProvider();
  late final GuardManagementController ctlGuardController;
  final List<SwitchCardModel> guardSwitches = [];

  @override
  void initState() {
    ctlGuardController = GuardManagementController(provider: guardProvider);
    super.initState();
  }

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
