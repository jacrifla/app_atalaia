import 'package:flutter/material.dart';

import '../provider/switch_provider.dart';
import '../utils/routes.dart';
import '../widgets/button_icon.dart';
import '../widgets/header.dart';
import '../widgets/menu.dart';
import '../widgets/switch_content.dart';
import '../controller/switch_controller.dart';
import '../model/switch_model.dart';

class SwitchScreen extends StatefulWidget {
  const SwitchScreen({super.key});

  @override
  State<SwitchScreen> createState() => _SwitchScreenState();
}

class _SwitchScreenState extends State<SwitchScreen> {
  final SwitchProvider switchProvider = SwitchProvider();
  late final SwitchController ctlSwitchController;
  late Future<List<SwitchModel>> _switchesFuture;

  @override
  void initState() {
    super.initState();
    ctlSwitchController = SwitchController(provider: switchProvider);
    _loadSwitches();
  }

  void _loadSwitches() {
    setState(() {
      _switchesFuture = ctlSwitchController.getSwitches();
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * 0.4;
    return Scaffold(
      appBar: const Header(title: 'Gerenciar Pontos'),
      endDrawer: const MenuDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: AnimatedBuilder(
                animation: ctlSwitchController,
                builder: ((context, child) {
                  return FutureBuilder<List<SwitchModel>>(
                    future: _switchesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Erro: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                            child: Text('Nenhum ponto encontrado.'));
                      } else {
                        return SwitchContent(
                          selectedIndex: 1,
                          switchesFuture: _switchesFuture,
                          isDeleting: true,
                        );
                      }
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: width,
              child: ButtonIcon(
                labelText: 'Adicionar',
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.switchCreate)
                      .then((_) {
                    _loadSwitches();
                  });
                },
                icon: const Icon(Icons.add),
              ),
            ),
            SizedBox(
              width: width,
              child: ButtonIcon(
                labelText: 'Atualizar',
                onPressed: _loadSwitches,
                icon: const Icon(Icons.refresh),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
