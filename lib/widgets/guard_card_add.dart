import 'package:flutter/material.dart';

import '../controller/guard_controller.dart';
import '../provider/guard_provider.dart';
import '../themes/theme.dart';
import '../utils/utils.dart';
import '../model/switch_model.dart';

class GuardCardAdd extends StatefulWidget {
  final SwitchModel switchModel;

  const GuardCardAdd({super.key, required this.switchModel});

  @override
  State<GuardCardAdd> createState() => _GuardCardAddState();
}

class _GuardCardAddState extends State<GuardCardAdd> {
  final GuardProvider guardProvider = GuardProvider();
  late GuardController ctlGuardController;

  @override
  void initState() {
    super.initState();
    ctlGuardController = GuardController(provider: guardProvider);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ctlGuardController,
      builder: (_, child) {
        return Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  toCapitalizeWords(
                      widget.switchModel.name ?? 'Unnamed Switch'),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: appTheme.primaryColor,
                  ),
                ),
                Switch(
                  value: widget.switchModel.guardActive ?? false,
                  onChanged: (bool value) async {
                    bool success = await ctlGuardController.defineSwitches(
                        widget.switchModel, value);
                    if (success) {
                      setState(() {
                        widget.switchModel.guardActive = value;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
