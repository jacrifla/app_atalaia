import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/switch_controller.dart';
import '../model/switch_model.dart';
import '../utils/auth_provider.dart';
import '../widgets/button_icon.dart';

class SwitchSelectionScreen extends StatefulWidget {
  final String groupName;
  final Function(Map<String, dynamic>) addSwitchToGroup;
  final String? groupId; // Adicione o groupId como um parâmetro opcional

  const SwitchSelectionScreen({
    super.key,
    required this.groupName,
    required this.addSwitchToGroup,
    this.groupId,
  });

  @override
  State<SwitchSelectionScreen> createState() => _SwitchSelectionScreenState();
}

class _SwitchSelectionScreenState extends State<SwitchSelectionScreen> {
  late Future<List<SwitchModel>> _switchesFuture;
  List<SwitchModel> selectedSwitches = [];

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userId = authProvider.userId;
    if (userId != null) {
      _switchesFuture =
          Provider.of<SwitchController>(context, listen: false).getSwitches();
    } else {
      _switchesFuture = Future.error('User ID is null');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groupName),
      ),
      body: FutureBuilder<List<SwitchModel>>(
        future: _switchesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No switches available'));
          }

          List<SwitchModel> availableSwitches = snapshot.data!;

          return ListView.builder(
            itemCount: availableSwitches.length,
            itemBuilder: (context, index) {
              SwitchModel switchItem = availableSwitches[index];
              return ListTile(
                title: Text(switchItem.name ?? 'Unknown'),
                trailing: IconButton(
                  icon: selectedSwitches.contains(switchItem)
                      ? const Icon(Icons.check_box)
                      : const Icon(Icons.check_box_outline_blank),
                  onPressed: () {
                    setState(() {
                      if (selectedSwitches.contains(switchItem)) {
                        selectedSwitches.remove(switchItem);
                      } else {
                        selectedSwitches.add(switchItem);
                      }
                    });
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ButtonIcon(
        onPressed: () async {
          Map<String, dynamic> data = {
            'groupId': widget.groupId,
            'switches': selectedSwitches
                .map((switchModel) => switchModel.userId)
                .toList(),
          };
          print(data);
          try {
            await widget.addSwitchToGroup(data);
          } catch (error) {
            print('Erro ao adicionar switches ao grupo: $error');
          }
        },
        labelText: 'Save',
        icon: const Icon(Icons.save),
      ),
    );
  }
}
