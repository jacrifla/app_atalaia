import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/guard_card.dart';
import '../widgets/menu.dart';
import '../widgets/switch_content.dart';
import '../controller/switch_controller.dart';
import '../model/switch_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late Future<List<SwitchModel>> _switchesFuture;

  @override
  void initState() {
    super.initState();
    _switchesFuture =
        Provider.of<SwitchController>(context, listen: false).getSwitches();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Home',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      endDrawer: const MenuDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GuardCard(),
            const SizedBox(height: 20),
            Expanded(
              child: SwitchContent(
                selectedIndex: _selectedIndex,
                switchesFuture: _switchesFuture,
              ),
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
}
