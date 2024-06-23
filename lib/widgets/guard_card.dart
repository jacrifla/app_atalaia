import 'package:app_atalaia/themes/theme.dart';
import 'package:flutter/material.dart';
import '../controller/guard_controller.dart';

class GuardCard extends StatefulWidget {
  final GuardController guardController;

  const GuardCard({super.key, required this.guardController});

  @override
  State<GuardCard> createState() => _GuardCardState();
}

class _GuardCardState extends State<GuardCard> {
  Color ativate = appTheme.primaryColor;
  Color desativate = appTheme.disabledColor;
  Color guardaButtonColor = appTheme.colorScheme.error;
  Color bgCard = appTheme.colorScheme.background;

  void _toggleGuarda() async {
    bool success = await widget.guardController.toggleGuard();
    if (success) {
      setState(() {
        // Atualiza a UI com base no novo estado da guarda
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.guardController,
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
                    color: widget.guardController.guardActive
                        ? ativate
                        : desativate,
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
                        widget.guardController.guardActive
                            ? 'Sua guarda está ativa no momento.'
                            : 'Sua guarda não está ativa no momento.',
                        style: TextStyle(
                          color: widget.guardController.guardActive
                              ? ativate
                              : desativate,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _toggleGuarda,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: widget.guardController.guardActive
                              ? guardaButtonColor
                              : ativate,
                          minimumSize: const Size(200, 40),
                        ),
                        child: Text(
                          widget.guardController.guardActive
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
