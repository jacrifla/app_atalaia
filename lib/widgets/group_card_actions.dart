import 'package:flutter/material.dart';
import '../view/group_edit_screen.dart';
import '../view/select_switches_screen.dart';
import '../model/group_model.dart';

class GroupCardActions extends StatelessWidget {
  final GroupModel groupInfo;

  const GroupCardActions({super.key, required this.groupInfo});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(20),
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                groupInfo.groupIcon,
                color: Theme.of(context).colorScheme.primary,
                size: 28,
              ),
              const SizedBox(height: 4),
              Text(
                groupInfo.groupName,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          title: Container(),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: Colors.blue,
                  size: 28,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditGroupScreen(
                        groupInfo: groupInfo,
                      ),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.add,
                  color: Colors.green,
                  size: 28,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SwitchSelectionScreen(),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 28,
                ),
                onPressed: () {
                  // Implemente a lógica para excluir o grupo
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
