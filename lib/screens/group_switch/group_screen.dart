// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

import '../../widgets/menu.dart';
import '../../widgets/button_icon.dart';
import '../../widgets/header.dart';
import 'create_group_screen.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  List<GroupInfo> userGroups = [
    GroupInfo(
      groupName: 'Grupo 1',
      groupIcon: Icons.group,
      groupCommon: true,
      randomTime: false,
      keepActive: false,
      keepActiveHours: 0,
      autoActivationTime: false,
      activationStartTime: '',
      activationEndTime: '',
    ),
    GroupInfo(
      groupName: 'Grupo 2',
      groupIcon: Icons.home,
      groupCommon: false,
      randomTime: true,
      keepActive: true,
      keepActiveHours: 2,
      autoActivationTime: true,
      activationStartTime: '10h',
      activationEndTime: '12h',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: 'Grupos'),
      endDrawer: MenuDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ButtonIcon(
              icon: Icon(Icons.add),
              labelText: 'Criar Novo Grupo',
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateGroupScreen()),
                );
              },
            ),
            SizedBox(height: 20),
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
    );
  }
}

class GroupInfo {
  final String groupName;
  final IconData groupIcon;
  final bool groupCommon;
  final bool randomTime;
  final bool keepActive;
  final int keepActiveHours;
  final bool autoActivationTime;
  final String activationStartTime;
  final String activationEndTime;

  GroupInfo({
    required this.groupName,
    required this.groupIcon,
    required this.groupCommon,
    required this.randomTime,
    required this.keepActive,
    required this.keepActiveHours,
    required this.autoActivationTime,
    required this.activationStartTime,
    required this.activationEndTime,
  });
}

class GroupCard extends StatelessWidget {
  final GroupInfo groupInfo;

  const GroupCard({super.key, required this.groupInfo});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      color: Theme.of(context).colorScheme.onSecondary,
      child: ListTile(
        onTap: () {},
        leading: Icon(
          groupInfo.groupIcon,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        title: Text(
          groupInfo.groupName,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.clear,
            color: Theme.of(context).colorScheme.error,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
