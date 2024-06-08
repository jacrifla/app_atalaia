import 'package:app_atalaia/provider/group_provider.dart';
import 'package:app_atalaia/themes/theme.dart';
import 'package:flutter/material.dart';
import '../core/constantes.dart';
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
    ctlGroupController = GroupController(provider: groupProvider);
    groupModel = widget.groupModel;
    isActive = groupModel.isActive ?? false;
    groupName = groupModel.groupName;
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
                      color: appTheme.colorScheme.background,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        isActive = !isActive;
                      });
                      // Atualizar o grupo no servidor
                      groupModel.isActive = isActive;
                      // await ctlGroupController.updateGroup(groupModel.toJson());
                    },
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
