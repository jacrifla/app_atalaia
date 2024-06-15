import 'package:app_atalaia/provider/group_provider.dart';
import 'package:app_atalaia/themes/theme.dart';
import 'package:flutter/material.dart';
import '../utils/constantes.dart';
import '../controller/group_controller.dart';
import '../model/group_model.dart';
import '../utils/utils.dart';

class GroupCardToggle extends StatefulWidget {
  final GroupModel groupModel;

  const GroupCardToggle({super.key, required this.groupModel});

  @override
  State<GroupCardToggle> createState() => _GroupCardToggleState();
}

class _GroupCardToggleState extends State<GroupCardToggle> {
  final GroupProvider groupProvider = GroupProvider();
  late final GroupController ctlGroupController;
  late GroupModel groupModel;
  late bool isActive;
  late String? groupName;

  @override
  void initState() {
    super.initState();
    groupModel = widget.groupModel;
    ctlGroupController = GroupController(provider: groupProvider);
    isActive = groupModel.isActive!;
    groupName = groupModel.groupName;
  }

  Future<void> _toggleGroup() async {
    setState(() {
      isActive = !isActive;
    });
    groupModel.isActive = isActive;
    await ctlGroupController.toggleGroup(
      groupModel.groupId!,
      isActive,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: groupName != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    toCapitalizeWords(groupName!),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: appTheme.primaryColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: _toggleGroup,
                    child: Icon(
                      Icons.lightbulb,
                      size: 40,
                      color: isActive ? activeColor : inactiveColor,
                    ),
                  ),
                ],
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
