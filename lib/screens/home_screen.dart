import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/menu.dart';
import '../utils/auth_provider.dart';
import 'switch/switch_card.dart';
import 'switch/switch_controller.dart';
import 'switch/switch_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;

  late Future<List<SwitchModel>> _switchesFuture;

  @override
  void initState() {
    super.initState();
    _loadSwitches();
  }

  void _loadSwitches() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userId = authProvider.userId;
    if (userId != null) {
      _switchesFuture = SwitchController().getSwitches(userId);
    } else {
      _switchesFuture = Future.error('User ID is null');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 1) {
        _loadSwitches();
      }
    });
  }

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
      endDrawer: const MenuDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GuardaCard(),
            const SizedBox(height: 20),
            Expanded(
              child: _buildSelectedContent(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Grupos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: 'Pontos',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildSelectedContent() {
    if (_selectedIndex == 0) {
      return const Center(child: Text('Conteúdo dos Grupos'));
    } else if (_selectedIndex == 1) {
      return FutureBuilder<List<SwitchModel>>(
        future: _switchesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum switch cadastrado'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return SwitchCard(switchModel: snapshot.data![index]);
              },
            );
          }
        },
      );
    }
    return Container();
  }
}

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
