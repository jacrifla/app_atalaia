// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

import '../widgets/button_icon.dart';
import '../widgets/header.dart';
import 'create_group_screen.dart';

class GroupScreen extends StatefulWidget {
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ButtonIcon(
              icon: Icon(Icons.add),
              labelText: 'Criar Novo Grupo',
              onPressed: () async {
                final newGroupData = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateGroupScreen()),
                );
                if (newGroupData != null) {
                  setState(() {
                    userGroups.add(GroupInfo(
                      groupName: newGroupData['groupName'],
                      groupIcon: newGroupData['groupIcon'],
                      groupCommon: newGroupData['groupCommon'],
                      randomTime: newGroupData['randomTime'],
                      keepActive: newGroupData['keepActive'],
                      keepActiveHours: newGroupData['keepActiveHours'],
                      autoActivationTime: newGroupData['autoActivationTime'],
                      activationStartTime: newGroupData['activationStartTime'],
                      activationEndTime: newGroupData['activationEndTime'],
                    ));
                  });
                }
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

  const GroupCard({required this.groupInfo});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        onTap: () {
          // Adicione aqui a lógica para exibir os detalhes do grupo
        },
        leading: Icon(groupInfo.groupIcon),
        title: Text(groupInfo.groupName),
        subtitle:
            Text(groupInfo.groupCommon ? 'Grupo Comum' : 'Grupo Especial'),
        trailing: IconButton(
          icon: Icon(
            Icons.clear,
            color: Theme.of(context).colorScheme.error,
          ),
          onPressed: () {
            // Adicione aqui a lógica para excluir o grupo
          },
        ),
      ),
    );
  }
}
