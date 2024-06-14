import 'package:app_atalaia/themes/theme.dart';
import 'package:flutter/material.dart';

class GuardCard extends StatefulWidget {
  const GuardCard({super.key});

  @override
  State<GuardCard> createState() => _GuardCardState();
}

class _GuardCardState extends State<GuardCard> {
  bool _guardaAtiva = false;
  Color ativate = appTheme.primaryColor;
  Color desativate = appTheme.disabledColor;
  Color guardaButtonColor = appTheme.colorScheme.error;
  Color bgCard = appTheme.colorScheme.background;

  void _toggleGuarda() {
    setState(() {
      _guardaAtiva = !_guardaAtiva;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                color: _guardaAtiva ? ativate : desativate,
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
                    _guardaAtiva
                        ? 'Sua guarda está ativa no momento.'
                        : 'Sua guarda não está ativa no momento.',
                    style: TextStyle(
                      color: _guardaAtiva ? ativate : desativate,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _toggleGuarda,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          !_guardaAtiva ? ativate : guardaButtonColor,
                      minimumSize: const Size(200, 40),
                    ),
                    child: Text(
                      _guardaAtiva ? 'Desativar Guarda' : 'Ativar Guarda Agora',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
