import 'package:flutter/material.dart';

class GuardCard extends StatefulWidget {
  const GuardCard({super.key});

  @override
  State<GuardCard> createState() => _GuardCardState();
}

class _GuardCardState extends State<GuardCard> {
  bool _guardaAtiva = false;

  void _toggleGuarda() {
    setState(() {
      _guardaAtiva = !_guardaAtiva;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: _guardaAtiva
          ? Theme.of(context).colorScheme.error
          : Theme.of(context).colorScheme.background,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.security,
                  size: 50,
                  color: _guardaAtiva
                      ? Theme.of(context).colorScheme.background
                      : Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
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
                        _guardaAtiva
                            ? 'Sua guarda está ativa no momento.'
                            : 'Sua guarda não está ativa no momento.',
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _toggleGuarda,
                        child: Text(_guardaAtiva
                            ? 'Desativar Guarda'
                            : 'Ativar Guarda Agora'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
