import 'package:flutter/material.dart';

import '../widgets/menu.dart';
import '../widgets/button_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String _selectedContent = 'Guarda';
  String _guardaStatusText = 'Sua guarda não está ativa no momento.';

  Color _cardBackgroundColor = Colors.white;
  Color _iconColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        title: Text(
          'Home',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      endDrawer: MenuDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ButtonIcon(
                labelText: 'Grupos',
                onPressed: () {
                  setState(() {
                    _selectedContent = 'Grupos';
                  });
                },
              ),
              ButtonIcon(
                labelText: 'Pontos',
                onPressed: () {
                  setState(() {
                    _selectedContent = 'Pontos';
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
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
                                  _iconColor =
                                      _cardBackgroundColor == Colors.red
                                          ? Colors.white
                                          : Colors.black;
                                  _guardaStatusText = _cardBackgroundColor ==
                                          Colors.red
                                      ? 'Sua guarda está ativa no momento.'
                                      : 'Sua guarda não está ativa no momento.';
                                });
                                // Implementar lógica para ativar a guarda aqui
                              },
                              child: Text('Ativar Guarda Agora'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          if (_selectedContent == 'Grupos') ...[
            Center(child: Text('Conteúdo dos Grupos')),
          ] else if (_selectedContent == 'Pontos') ...[
            Center(child: Text('Conteúdo dos Pontos')),
          ],
        ],
      ),
    );
  }
}
