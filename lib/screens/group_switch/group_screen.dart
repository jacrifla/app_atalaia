// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../../widgets/menu.dart';
import '../../widgets/button_icon.dart';
import '../../widgets/header.dart';
import 'group_create_screen.dart';
import 'group_card_delete.dart';
import 'group_model.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  List<GroupModel> userGroups = [
    GroupModel(
      groupId: '1',
      groupName: 'Grupo 1',
      groupIcon: Icons.group,
      groupCommon: true,
      randomTime: false,
      keepActive: false,
      keepActiveHours: 0,
      autoActivationTime: false,
      activationStartTime: '',
      activationEndTime: '',
      isActive: true,
    ),
    GroupModel(
      groupId: '2',
      groupName: 'Grupo 2',
      groupIcon: Icons.home,
      groupCommon: false,
      randomTime: true,
      keepActive: true,
      keepActiveHours: 2,
      autoActivationTime: true,
      activationStartTime: '10h',
      activationEndTime: '12h',
      isActive: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(title: 'Grupos'),
      endDrawer: const MenuDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: userGroups.length,
                itemBuilder: (context, index) {
                  final group = userGroups[index];
                  return GroupCard(groupInfo: group);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ButtonIcon(
        icon: const Icon(Icons.add),
        labelText: 'Criar Novo Grupo',
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateGroupScreen()),
          );
        },
      ),
    );
  }
}
