import 'package:flutter/material.dart';

import 'group_screen.dart';

class EditGroupScreen extends StatefulWidget {
  final GroupInfo groupInfo;

  const EditGroupScreen({Key? key, required this.groupInfo}) : super(key: key);

  @override
  _EditGroupScreenState createState() => _EditGroupScreenState();
}

class _EditGroupScreenState extends State<EditGroupScreen> {
  late TextEditingController _groupNameController;
  late bool _groupCommon;
  // Adicione os outros campos conforme necessário

  @override
  void initState() {
    super.initState();
    _groupNameController =
        TextEditingController(text: widget.groupInfo.groupName);
    _groupCommon = widget.groupInfo.groupCommon;
    // Inicialize outros campos aqui conforme necessário
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
        title: Text('Editar Grupo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _groupNameController,
              decoration: InputDecoration(labelText: 'Nome do Grupo'),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Grupo Comum: '),
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
            // Adicione outros campos de edição aqui conforme necessário
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Salvar as alterações e retornar para a tela anterior
                final editedGroupInfo = GroupInfo(
                  groupName: _groupNameController.text,
                  groupIcon: widget.groupInfo.groupIcon,
                  groupCommon: _groupCommon,
                  // Passe outros campos editados aqui
                  randomTime: widget.groupInfo.randomTime,
                  keepActive: widget.groupInfo.keepActive,
                  keepActiveHours: widget.groupInfo.keepActiveHours,
                  autoActivationTime: widget.groupInfo.autoActivationTime,
                  activationStartTime: widget.groupInfo.activationStartTime,
                  activationEndTime: widget.groupInfo.activationEndTime,
                );
                Navigator.pop(context, editedGroupInfo);
              },
              child: Text('Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }
}
