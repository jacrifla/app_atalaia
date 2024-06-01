// ignore_for_file: use_build_context_synchronously

import 'package:app_atalaia/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constantes.dart';
import '../utils/auth_provider.dart';
import '../utils/utils.dart';
import '../controller/group_controller.dart';
import '../model/group_model.dart';
import '../view/error_screen.dart';
import '../view/success_screen.dart';

class GroupCardToggle extends StatefulWidget {
  final GroupModel groupInfo;

  const GroupCardToggle({super.key, required this.groupInfo});

  @override
  State<GroupCardToggle> createState() => _GroupCardToggleState();
}

class _GroupCardToggleState extends State<GroupCardToggle> {
  late bool isActive;

  @override
  void initState() {
    super.initState();
    isActive = widget.groupInfo.isActive;
  }

  Future<void> _toggleGroup(
      BuildContext context, GroupController groupController) async {
    final groupId = widget.groupInfo.groupId;
    final newStatus = !isActive;

    try {
      bool success = await groupController
          .toggleGroup({'group_id': groupId, 'is_active': newStatus});

      if (!mounted) return;

      if (success) {
        setState(() {
          isActive = newStatus;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SuccessScreen(
              message: 'Grupo alternado com sucesso',
              alternativeRoute: AppRoutes.groupScreen,
            ),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ErrorScreen(
              errorDescription: 'Erro',
              message: 'Falha ao alternar grupo',
            ),
          ),
        );
      }
    } catch (error) {
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ErrorScreen(
            errorDescription: 'Erro ao alternar grupo',
            message: '$error',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final groupController = Provider.of<GroupController>(context);
    final userId = Provider.of<AuthProvider>(context).userId;

    if (userId == null) {
      return const Text('Usuário não autenticado');
    }

    return Card(
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
              onTap: () => _toggleGroup(context, groupController),
              child: Icon(
                Icons.group,
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
