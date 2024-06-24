import 'package:app_atalaia/utils/constantes.dart';
import 'package:flutter/material.dart';
import '../themes/theme.dart';
import '../controller/group_controller.dart';
import '../provider/group_provider.dart';
import '../model/group_model.dart';
import '../utils/utils.dart';
import '../view/group_edit_screen.dart';
import '../view/select_switches_screen.dart';

class GroupCardActions extends StatefulWidget {
  final GroupModel groupModel;

  const GroupCardActions({super.key, required this.groupModel});

  @override
  State<GroupCardActions> createState() => _GroupCardActionsState();
}

class _GroupCardActionsState extends State<GroupCardActions> {
  final GroupProvider groupProvider = GroupProvider();
  late final GroupController ctlGroupController;
  late List<GroupModel> groups;

  @override
  void initState() {
    ctlGroupController = GroupController(provider: groupProvider);
    _loadGroups();
    super.initState();
  }

  // Método para carregar os grupos
  void _loadGroups() async {
    List<GroupModel> loadedGroups = await ctlGroupController.getAllGroups();
    if (mounted) {
      setState(() {
        groups = loadedGroups;
      });
    }
  }

  // Método para excluir o grupo
  Future<void> _deleteGroup(String groupId) async {
    try {
      bool confirmed = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirmar exclusão'),
            content: const Text('Tem certeza que deseja excluir este grupo?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Confirmar'),
              ),
            ],
          );
        },
      );

      if (confirmed == true) {
        // Chame o método de exclusão do controlador
        await ctlGroupController.deleteGroup(groupId);
        // Atualize a lista de grupos após a exclusão
        _loadGroups();
        // Exiba uma mensagem informando que o grupo foi excluído com sucesso
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Grupo excluído com sucesso'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao excluir grupo: $error'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

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
                    color: appTheme.primaryColor,
                    size: 28,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    toCapitalizeWords(widget.groupModel.groupName ?? 'Unknown'),
                    style: TextStyle(
                      color: appTheme.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
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
                      color: edit,
                      size: 28,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditGroupScreen(
                            groupInfo: widget.groupModel,
                          ),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.add,
                      color: success,
                      size: 28,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SwitchSelectionScreen(
                            groupId: widget.groupModel.groupId,
                            groupName: widget.groupModel.groupName ?? 'Unknown',
                          ),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: delete,
                      size: 28,
                    ),
                    onPressed: () => _deleteGroup(widget.groupModel.groupId!),
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
