import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constantes.dart';
import '../controller/group_controller.dart';
import '../model/group_model.dart';
import '../utils/utils.dart';

class GroupCardToggle extends StatefulWidget {
  final GroupModel groupInfo;

  const GroupCardToggle({super.key, required this.groupInfo});

  @override
  State<GroupCardToggle> createState() => _GroupCardToggleState();
}

class _GroupCardToggleState extends State<GroupCardToggle> {
  late bool isActive;
  late String groupName;

  @override
  void initState() {
    super.initState();
    isActive = widget.groupInfo.isActive ?? true;
    groupName = toCapitalizeWords(widget.groupInfo.groupName!);
  }

  Future<void> _toggleGroup(BuildContext context) async {
    final groupController =
        Provider.of<GroupController>(context, listen: false);
    final groupId = widget.groupInfo.groupId;

    print('Clicou na lâmpada do grupo com o ID: $groupId');
    final newStatus = !isActive;

    try {
      bool success = await groupController.toggleGroup({
        'group_id': groupId,
        'is_active': newStatus,
      });

      if (success) {
        setState(() {
          isActive = newStatus;
        });
      }
    } catch (error) {
      // Handle error appropriately
      print('Erro ao alternar grupo: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              groupName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () => _toggleGroup(context),
              child: Icon(
                Icons.lightbulb,
                size: 40,
                color: isActive ? activeColor : inactiveColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
