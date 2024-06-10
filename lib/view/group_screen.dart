import 'package:flutter/material.dart';
import '../controller/group_controller.dart';
import '../model/group_model.dart';
import '../provider/group_provider.dart';
import '../widgets/button_icon.dart';
import '../widgets/group_card_actions.dart';
import '../widgets/header_screen.dart';
import 'group_create_screen.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  final GroupProvider groupProvider = GroupProvider();
  late final GroupController ctlGroupController;

  // Lista para armazenar os grupos obtidos
  List<GroupModel> groups = [];

  @override
  void initState() {
    ctlGroupController = GroupController(provider: groupProvider);
    _loadGroups(); // Carrega os grupos ao iniciar a tela
    super.initState();
  }

  // Método para carregar os grupos
  void _loadGroups() async {
    List<GroupModel> loadedGroups = await ctlGroupController.getAllGroups();
    setState(() {
      groups = loadedGroups;
    });
  }

  void _navigateToCreateGroup(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateGroupScreen()),
    );
  }

  void _refreshGroups() {
    setState(() {
      _loadGroups();
    });
  }

  @override
  Widget build(BuildContext context) {
    return HeaderScreen(
      title: 'Grupos',
      body: FutureBuilder(
        future: ctlGroupController.getAllGroups(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar grupos: ${snapshot.error}'),
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: groups.length,
              itemBuilder: (context, index) {
                if (groups.isNotEmpty && index < groups.length) {
                  return GroupCardActions(
                    groupModel: groups[index],
                  );
                } else {
                  return const SizedBox();
                }
              },
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ButtonIcon(
              labelText: 'Criar Grupo',
              onPressed: () => _navigateToCreateGroup(context),
              icon: const Icon(Icons.add),
            ),
            ButtonIcon(
              labelText: 'Atualizar',
              onPressed: _refreshGroups,
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
      ),
    );
  }
}
