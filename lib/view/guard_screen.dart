import 'package:flutter/material.dart';
import '../controller/guard_controller.dart';
import '../provider/guard_provider.dart';
import '../model/switch_model.dart';
import '../widgets/header.dart';
import '../widgets/menu.dart';
import '../widgets/guard_card_add.dart';

class GuardScreen extends StatefulWidget {
  const GuardScreen({super.key});

  @override
  State<GuardScreen> createState() => _GuardScreenState();
}

class _GuardScreenState extends State<GuardScreen> {
  final GuardProvider guardProvider = GuardProvider();
  late final GuardController ctlGuardController;
  final List<SwitchModel> guardSwitches = [];

  @override
  void initState() {
    super.initState();
    ctlGuardController = GuardController(provider: guardProvider);
    _loadGuardSwitches();
  }

  Future<void> _loadGuardSwitches() async {
    bool success = await ctlGuardController.getGuardInfo();
    if (success && ctlGuardController.guardInfo != null) {
      setState(() {
        guardSwitches.clear();
        guardSwitches.addAll(ctlGuardController.guardInfo!.switches ?? []);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(title: 'Ger. Guarda'),
      endDrawer: const MenuDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: guardSwitches.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: guardSwitches.length,
                itemBuilder: (context, index) {
                  return GuardCardAdd(switchModel: guardSwitches[index]);
                },
              ),
      ),
    );
  }
}
