import 'package:flutter/material.dart';

import '../controller/group_controller.dart';
import '../controller/switch_controller.dart';
import '../controller/guard_controller.dart';
import '../provider/group_provider.dart';
import '../provider/switch_provider.dart';
import '../provider/guard_provider.dart';
import '../widgets/guard_card.dart';
import '../widgets/menu.dart';
import '../widgets/group_card_toggle.dart';
import '../model/group_model.dart';
import '../model/switch_model.dart';
import '../widgets/switch_card_toggle.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SwitchProvider switchProvider = SwitchProvider();
  final GroupProvider groupProvider = GroupProvider();
  final GuardProvider guardProvider = GuardProvider();
  late final SwitchController ctlSwitchController;
  late final GroupController ctlGroupController;
  late final GuardController guardController;

  int _selectedIndex = 0;
  late List<GroupModel> userGroups = [];
  late List<SwitchModel> userSwitches = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    ctlSwitchController = SwitchController(provider: switchProvider);
    ctlGroupController = GroupController(provider: groupProvider);
    guardController = GuardController(provider: guardProvider);
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });
    final groups = await ctlGroupController.getAllGroups();
    final switches = await ctlSwitchController.getSwitches();
    await guardController.getGuardInfo();
    setState(() {
      userGroups = groups;
      userSwitches = switches;
      _isLoading = false;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildGroupCards() {
    return ListView.builder(
      itemCount: userGroups.length,
      itemBuilder: (context, index) {
        final group = userGroups[index];
        return GroupCardToggle(groupModel: group);
      },
    );
  }

  Widget _buildSwitchCards() {
    return ListView.builder(
      itemCount: userSwitches.length,
      itemBuilder: (context, index) {
        final switchItem = userSwitches[index];
        return SwitchCard(switchModel: switchItem);
      },
    );
  }

  Widget _buildSelectedScreen() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (guardController.guardActive) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Guarda Ativa',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            Text(
              'Desative a guarda para usar as outras funções',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
      );
    }

    switch (_selectedIndex) {
      case 0:
        return _buildGroupCards();
      case 1:
        return _buildSwitchCards();
      default:
        return Container();
    }
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
            GuardCard(
              guardController: guardController,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: AnimatedBuilder(
                animation: Listenable.merge(
                    [ctlGroupController, ctlSwitchController, guardController]),
                builder: (context, _) {
                  return _buildSelectedScreen();
                },
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
