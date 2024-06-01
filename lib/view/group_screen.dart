import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/auth_provider.dart';
import '../widgets/button_icon.dart';
import '../widgets/header.dart';
import '../widgets/menu.dart';
import '../controller/group_controller.dart';
import 'group_create_screen.dart';
import '../model/group_model.dart';
import '../widgets/group_card_actions.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  late Future<List<GroupModel>> _groupsFuture;

  @override
  void initState() {
    super.initState();
    _loadGroups();
  }

  void _loadGroups() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userId = authProvider.userId;
    if (userId != null) {
      _groupsFuture = GroupController().getGroups(context);
    } else {
      _groupsFuture = Future.error('User ID is null');
    }
  }

  void _refreshGroups() {
    setState(() {
      _loadGroups();
    });
  }

  void _navigateToCreateGroup() {
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
              child: FutureBuilder<List<GroupModel>>(
                future: _groupsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Erro ao carregar grupos: ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    final groups = snapshot.data!;
                    return ListView.builder(
                      itemCount: groups.length,
                      itemBuilder: (context, index) {
                        final group = groups[index];
                        return GroupCardActions(groupInfo: group);
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('Nenhum grupo encontrado.'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ButtonIcon(
              labelText: 'Criar Novo Grupo',
              onPressed: _navigateToCreateGroup,
              icon: const Icon(Icons.add),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          ),
          ButtonIcon(
            labelText: 'Atualizar Grupos',
            onPressed: _refreshGroups,
            icon: const Icon(Icons.refresh),
            backgroundColor: Theme.of(context).colorScheme.onSecondary,
          ),
        ],
      ),
    );
  }
}
