import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/auth_provider.dart';
import '../widgets/button_icon.dart';
import '../widgets/header.dart';
import '../widgets/menu.dart';
import '../controller/group_controller.dart';
import 'group_create_screen.dart';
import '../model/group_model.dart';
import '../widgets/group_content.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  late Future<List<GroupModel>> _groupsFuture;
  final GroupController _groupController = GroupController();

  @override
  void initState() {
    super.initState();
    _loadGroups();
  }

  void _loadGroups() {
    setState(() {
      _groupsFuture = _groupController.loadGroups();
    });
  }

  void _refreshGroups() {
    setState(() {
      _loadGroups();
    });
  }

  void _navigateToCreateGroup(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateGroupScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userId = authProvider.userId;

    if (userId == null) {
      return const Scaffold(
        body: Center(
          child: Text('Erro: usuário não autenticado'),
        ),
      );
    }

    return Scaffold(
      appBar: const Header(title: 'Grupos'),
      endDrawer: const MenuDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: GroupContent(
                groupsFuture: _groupsFuture,
                isDeleting: true,
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
            ButtonIcon(
              labelText: 'Criar Novo Grupo',
              onPressed: () => _navigateToCreateGroup(context),
              icon: const Icon(Icons.add),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            ButtonIcon(
              labelText: 'Atualizar Grupos',
              onPressed: _refreshGroups,
              icon: const Icon(Icons.refresh),
              backgroundColor: Theme.of(context).colorScheme.onSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
