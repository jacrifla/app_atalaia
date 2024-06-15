import 'package:app_atalaia/themes/theme.dart';
import 'package:flutter/material.dart';
import '../controller/guard_controller.dart';
import '../provider/guard_provider.dart';

class GuardCard extends StatefulWidget {
  const GuardCard({super.key});

  @override
  State<GuardCard> createState() => _GuardCardState();
}

class _GuardCardState extends State<GuardCard> {
  Color ativate = appTheme.primaryColor;
  Color desativate = appTheme.disabledColor;
  Color guardaButtonColor = appTheme.colorScheme.error;
  Color bgCard = appTheme.colorScheme.background;
  late GuardController ctlGuardController;

  @override
  void initState() {
    super.initState();
    final guardProvider = GuardProvider();
    ctlGuardController = GuardController(provider: guardProvider);
  }

  void _toggleGuarda() async {
    bool success = await ctlGuardController.toggleGuard();
    if (success) {
      setState(() {
        // Não é necessário gerenciar _guardaAtiva aqui, pois é gerenciado pelo controlador
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ctlGuardController,
      builder: (context, _) {
        return Card(
          elevation: 3,
          color: bgCard,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(
                    Icons.security,
                    size: 50,
                    color:
                        ctlGuardController.guardActive ? ativate : desativate,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Guarda'.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        ctlGuardController.guardActive
                            ? 'Sua guarda está ativa no momento.'
                            : 'Sua guarda não está ativa no momento.',
                        style: TextStyle(
                          color: ctlGuardController.guardActive
                              ? ativate
                              : desativate,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _toggleGuarda,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ctlGuardController.guardActive
                              ? guardaButtonColor
                              : ativate,
                          minimumSize: const Size(200, 40),
                        ),
                        child: Text(
                          ctlGuardController.guardActive
                              ? 'Desativar Guarda'
                              : 'Ativar Guarda Agora',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
