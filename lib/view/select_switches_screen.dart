import 'package:app_atalaia/controller/group_controller.dart';
import 'package:app_atalaia/model/group_model.dart';
import 'package:app_atalaia/provider/group_provider.dart';
import 'package:app_atalaia/provider/switch_provider.dart';
import 'package:flutter/material.dart';

import '../controller/switch_controller.dart';
import '../model/switch_model.dart';
import '../widgets/button_icon.dart';
import '../utils/utils.dart';

class SwitchSelectionScreen extends StatefulWidget {
  final String? groupName;
  final String? groupId;

  const SwitchSelectionScreen({
    super.key,
    this.groupName,
    this.groupId,
  });

  @override
  State<SwitchSelectionScreen> createState() => _SwitchSelectionScreenState();
}

class _SwitchSelectionScreenState extends State<SwitchSelectionScreen> {
  final GroupProvider groupProvider = GroupProvider();
  final SwitchProvider switchProvider = SwitchProvider();
  late GroupController groupController;
  late SwitchController switchController;
  late GroupModel groupModel;
  late Future<List<SwitchModel>> futureSwitches;
  List<SwitchModel> selectedSwitches = [];

  @override
  void initState() {
    super.initState();
    groupController = GroupController(provider: groupProvider);
    switchController = SwitchController(switchProvider);
    groupModel = GroupModel();
    futureSwitches = switchController.getSwitchesWithoutGroup();
  }

  Future<void> _addSwitchToGroup(SwitchModel switchModel) async {
    try {
      await groupController.addSwitchToGroup(
          widget.groupId!, switchModel.macAddress!);
      setState(() {
        selectedSwitches.add(switchModel);
        switchModel.groupId = widget.groupId;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao adicionar switch ao grupo: $error')),
      );
    }
  }

  Future<void> _removeSwitchFromGroup(SwitchModel switchModel) async {
    try {
      await groupController.removeSwitchFromGroup(switchModel.macAddress!);
      setState(() {
        selectedSwitches.remove(switchModel);
        switchModel.groupId = null;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao remover switch do grupo: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(toCapitalizeWords(widget.groupName ?? '')),
      ),
      body: FutureBuilder<List<SwitchModel>>(
        future: futureSwitches,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No switches available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final switchItem = snapshot.data![index];
                final isSelected = selectedSwitches.contains(switchItem);

                return ListTile(
                  title: Text(toCapitalizeWords(switchItem.name ?? '')),
                  trailing: IconButton(
                    icon: isSelected
                        ? const Icon(Icons.check_box)
                        : const Icon(Icons.check_box_outline_blank),
                    onPressed: () {
                      if (isSelected) {
                        _removeSwitchFromGroup(switchItem);
                      } else {
                        _addSwitchToGroup(switchItem);
                      }
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ButtonIcon(
        onPressed: () async {
          // Adicionar lógica adicional de salvamento se necessário
        },
        labelText: 'Save',
        icon: const Icon(Icons.save),
      ),
    );
  }
}
