import 'package:flutter/material.dart';

class GuardaCard extends StatefulWidget {
  const GuardaCard({super.key});

  @override
  _GuardaCardState createState() => _GuardaCardState();
}

class _GuardaCardState extends State<GuardaCard> {
  String _guardaStatusText = 'Sua guarda não está ativa no momento.';
  Color _cardBackgroundColor = Colors.white;
  Color _iconColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: _cardBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.security,
                  size: 50,
                  color: _iconColor,
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Guarda',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      _guardaStatusText,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _cardBackgroundColor =
                              _cardBackgroundColor == Colors.red
                                  ? Colors.white
                                  : Colors.red;
                          _iconColor = _cardBackgroundColor == Colors.red
                              ? Colors.white
                              : Colors.black;
                          _guardaStatusText = _cardBackgroundColor == Colors.red
                              ? 'Sua guarda está ativa no momento.'
                              : 'Sua guarda não está ativa no momento.';
                        });
                        // Implementar lógica para ativar a guarda aqui
                      },
                      child: const Text('Ativar Guarda Agora'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
