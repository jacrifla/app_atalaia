import 'package:flutter/material.dart';

import 'group_switch/group_screen.dart';

class EditGroupScreen extends StatefulWidget {
  final GroupInfo groupInfo;

  const EditGroupScreen({super.key, required this.groupInfo});

  @override
  _EditGroupScreenState createState() => _EditGroupScreenState();
}

class _EditGroupScreenState extends State<EditGroupScreen> {
  late TextEditingController _groupNameController;
  late bool _groupCommon;

  @override
  void initState() {
    super.initState();
    _groupNameController =
        TextEditingController(text: widget.groupInfo.groupName);
    _groupCommon = widget.groupInfo.groupCommon;
  }

  @override
  void dispose() {
    _groupNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Grupo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _groupNameController,
              decoration: const InputDecoration(labelText: 'Nome do Grupo'),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('Grupo Comum: '),
                Switch(
                  value: _groupCommon,
                  onChanged: (value) {
                    setState(() {
                      _groupCommon = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final editedGroupInfo = GroupInfo(
                  groupName: _groupNameController.text,
                  groupIcon: widget.groupInfo.groupIcon,
                  groupCommon: _groupCommon,
                  randomTime: widget.groupInfo.randomTime,
                  keepActive: widget.groupInfo.keepActive,
                  keepActiveHours: widget.groupInfo.keepActiveHours,
                  autoActivationTime: widget.groupInfo.autoActivationTime,
                  activationStartTime: widget.groupInfo.activationStartTime,
                  activationEndTime: widget.groupInfo.activationEndTime,
                );
                Navigator.pop(context, editedGroupInfo);
              },
              child: const Text('Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }
}
