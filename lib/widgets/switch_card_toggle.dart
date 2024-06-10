import 'package:flutter/material.dart';
import '../core/constantes.dart';
import '../provider/switch_provider.dart';
import '../themes/theme.dart';
import '../utils/utils.dart';
import '../model/switch_model.dart';
import '../controller/switch_controller.dart';

class SwitchCard extends StatefulWidget {
  final SwitchModel switchModel;

  const SwitchCard({super.key, required this.switchModel});

  @override
  State<SwitchCard> createState() => _SwitchCardState();
}

class _SwitchCardState extends State<SwitchCard> {
  final SwitchProvider switchProvider = SwitchProvider();
  late final SwitchController ctlSwitchController;
  late bool isActive;

  @override
  void initState() {
    super.initState();
    ctlSwitchController = SwitchController(provider: switchProvider);
    isActive = widget.switchModel.isActive!;
    print("isActive: ${widget.switchModel.isActive}");
  }

  Future<void> _toggleSwitch() async {
    bool success = await ctlSwitchController.toggleSwitch(
      isActive: !isActive,
      macAddress: widget.switchModel.macAddress!,
    );
    if (success) {
      setState(() {
        isActive = !isActive;
        widget.switchModel.isActive = isActive;
      });
    }
  }

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
                color: appTheme.colorScheme.background,
              ),
            ),
            AnimatedBuilder(
              animation: ctlSwitchController,
              builder: (_, child) {
                return GestureDetector(
                  onTap: _toggleSwitch,
                  child: Icon(
                    Icons.lightbulb,
                    size: 40,
                    color: isActive ? activeColor : inactiveColor,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
