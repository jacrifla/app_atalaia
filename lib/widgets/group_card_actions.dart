import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/group_controller.dart';
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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.group,
                    color: Theme.of(context).colorScheme.primary,
                    size: 28,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    groupInfo.groupName ?? 'Unknown',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          builder: (context) => SwitchSelectionScreen(
                            groupId:
                                groupInfo.groupId, // Passando o groupId aqui
                            addSwitchToGroup: (Map<String, dynamic> data) {
                              data['groupId'] = groupInfo.groupId;
                            },
                            groupName: groupInfo.groupName ?? 'Unknown',
                          ),
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
                    onPressed: () async {
                      try {
                        final groupId = groupInfo.groupId;
                        if (groupId != null) {
                          await Provider.of<GroupController>(context,
                                  listen: false)
                              .deleteGroup(groupId);
                        } else {
                          print('groupId is null. Cannot delete group.');
                        }
                      } catch (error) {
                        print('Erro ao excluir o grupo: $error');
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
