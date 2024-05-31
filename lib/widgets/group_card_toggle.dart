// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/auth_provider.dart';
import '../utils/utils.dart';
import '../controller/group_controller.dart';
import '../model/group_model.dart';

class GroupCard extends StatefulWidget {
  final GroupModel groupInfo;

  const GroupCard({super.key, required this.groupInfo});

  @override
  _GroupCardState createState() => _GroupCardState();
}

class _GroupCardState extends State<GroupCard> {
  late bool isActive;

  @override
  void initState() {
    super.initState();
    isActive = widget.groupInfo.isActive;
  }

  @override
  Widget build(BuildContext context) {
    final groupController = Provider.of<GroupController>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final userId = authProvider.userId;

    if (userId == null) {
      return const Text('Usuário não autenticado');
    }

    return Card(
      color: Theme.of(context).colorScheme.onSecondary,
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              toCapitalizeWords(widget.groupInfo.groupName),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.background,
              ),
            ),
            GestureDetector(
              onTap: () async {
                print('Toggling group: ${widget.groupInfo.groupName}');
                bool success = await groupController.toggleGroup(
                  widget.groupInfo.groupId,
                  !isActive,
                  userId,
                );
                if (success) {
                  print('Toggle successful, updating state.');
                  setState(() {
                    isActive = !isActive;
                  });
                } else {
                  print('Toggle failed.');
                }
              },
              child: Icon(
                Icons.group,
                size: 40,
                color: isActive ? Colors.yellowAccent : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
