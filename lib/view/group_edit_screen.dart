import 'package:flutter/material.dart';
import '../widgets/build_input.dart';
import '../widgets/button_icon.dart';
import '../widgets/header.dart';
import '../widgets/menu.dart';
import 'success_screen.dart';
import '../model/group_model.dart';
import '../controller/group_controller.dart';
import 'error_screen.dart';

class EditGroupScreen extends StatefulWidget {
  final GroupModel groupInfo;

  const EditGroupScreen({super.key, required this.groupInfo});

  @override
  State<EditGroupScreen> createState() => _EditGroupScreenState();
}

class _EditGroupScreenState extends State<EditGroupScreen> {
  late TextEditingController _inputNomeGrupo;
  late bool isActive;
  late bool scheduleActive;
  late TextEditingController _inputScheduleStart;
  late TextEditingController _inputScheduleEnd;
  late TextEditingController _inputMacAddress;
  final GroupController _groupController = GroupController();

  @override
  void initState() {
    super.initState();
    _inputNomeGrupo =
        TextEditingController(text: widget.groupInfo.groupName ?? '');
    isActive = widget.groupInfo.isActive ?? false;
    scheduleActive = widget.groupInfo.scheduleActive ?? false;
    _inputScheduleStart =
        TextEditingController(text: widget.groupInfo.scheduleStart ?? '');
    _inputScheduleEnd =
        TextEditingController(text: widget.groupInfo.scheduleEnd ?? '');
    _inputMacAddress =
        TextEditingController(text: widget.groupInfo.macAddress ?? '');
  }

  @override
  void dispose() {
    _inputNomeGrupo.dispose();
    _inputScheduleStart.dispose();
    _inputScheduleEnd.dispose();
    _inputMacAddress.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    final updatedGroup = {
      'group_id': widget.groupInfo.groupId,
      'name': _inputNomeGrupo.text,
      'is_active': isActive,
      'schedule_active': scheduleActive,
      'schedule_start': _inputScheduleStart.text,
      'schedule_end': _inputScheduleEnd.text,
    };

    try {
      await _groupController.updateGroupInfo(updatedGroup);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SuccessScreen(
            message: 'Alterações salvas com sucesso',
            screen: '/group_switch',
          ),
        ),
      );
    } catch (error) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ErrorScreen(
            message: 'Erro',
            errorDescription: error.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(title: 'Editar Grupo'),
      endDrawer: const MenuDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BuildInput(
                icon: const Icon(Icons.face),
                labelText: 'Nome',
                controller: _inputNomeGrupo,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do grupo.';
                  }
                  return null;
                },
                maxLength: 24,
              ),
              const SizedBox(height: 16.0),
              CheckboxListTile(
                title: const Text('Ativo'),
                value: isActive,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) {
                  setState(() {
                    isActive = value ?? false;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Ativação Automática'),
                value: scheduleActive,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) {
                  setState(() {
                    scheduleActive = value ?? false;
                  });
                },
              ),
              if (scheduleActive)
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: 'De'),
                        controller: _inputScheduleStart,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: 'Até'),
                        controller: _inputScheduleEnd,
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ButtonIcon(
          labelText: 'Salvar Alterações',
          onPressed: _saveChanges,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
