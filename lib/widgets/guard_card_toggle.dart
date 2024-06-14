import 'package:flutter/material.dart';

import '../themes/theme.dart';
import '../utils/utils.dart';
import '../model/switch_model.dart';

class GuardToggle extends StatefulWidget {
  final SwitchModel switchModel;

  const GuardToggle({super.key, required this.switchModel});

  @override
  State<GuardToggle> createState() => _GuardToggleState();
}

class _GuardToggleState extends State<GuardToggle> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
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
                color: appTheme.primaryColor,
              ),
            ),
            // AnimatedBuilder(
            //   animation: ctlSwitchController,
            //   builder: (_, child) {
            //     return GestureDetector(
            //       onTap: _toggleSwitch,
            //       child: Icon(
            //         Icons.lightbulb,
            //         size: 40,
            //         color: isActive ? activeColor : inactiveColor,
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
