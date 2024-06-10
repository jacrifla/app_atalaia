import 'package:flutter/material.dart';

import '../widgets/button_icon.dart';
import '../widgets/header.dart';
import '../widgets/menu.dart';
import '../model/group_model.dart';
import '../provider/group_provider.dart';
import '../controller/group_controller.dart';

class EditGroupScreen extends StatefulWidget {
  final GroupModel groupInfo;

  const EditGroupScreen({super.key, required this.groupInfo});

  @override
  State<EditGroupScreen> createState() => _EditGroupScreenState();
}

class _EditGroupScreenState extends State<EditGroupScreen> {
  final GroupProvider groupProvider = GroupProvider();
  late final GroupController ctlGroupController;
  final TextEditingController _inputNomeGrupo = TextEditingController();
  final TextEditingController _inputScheduleStart = TextEditingController();
  final TextEditingController _inputScheduleEnd = TextEditingController();
  TimeOfDay fromTime = TimeOfDay.now();
  TimeOfDay toTime = TimeOfDay.now();

  @override
  void initState() {
    ctlGroupController = GroupController(provider: groupProvider);
    _inputNomeGrupo.text = widget.groupInfo.groupName ?? "";
    _inputScheduleStart.text = widget.groupInfo.scheduleStart ?? "";
    _inputScheduleEnd.text = widget.groupInfo.scheduleEnd ?? "";
    super.initState();
  }

  @override
  void dispose() {
    _inputNomeGrupo.dispose();
    _inputScheduleStart.dispose();
    _inputScheduleEnd.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    try {
      await ctlGroupController.updateGroup(
        widget.groupInfo.groupId!,
        _inputNomeGrupo.text,
        true,
        true,
        _inputScheduleStart.text,
        _inputScheduleEnd.text,
      );
      _showSuccessSnackbar('Alterações salvas com sucesso');
    } catch (error) {
      _showErrorSnackbar('Erro', error.toString());
    }
  }

  void _showErrorSnackbar(String message, String errorDescription) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context);
  }

  Future<void> _selectTime(BuildContext context, bool isFromTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isFromTime) {
          fromTime = picked;
          _inputScheduleStart.text = picked.format(context);
        } else {
          toTime = picked;
          _inputScheduleEnd.text = picked.format(context);
        }
      });
    }
  }

  Widget _buildTimePickerField(BuildContext context, bool isFromTime) {
    final TimeOfDay time = isFromTime ? fromTime : toTime;
    return Expanded(
      child: InkWell(
        onTap: () => _selectTime(context, isFromTime),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: isFromTime ? 'De' : 'Até',
            hintText: '${time.hour}:${time.minute}',
            prefixIcon: const Icon(Icons.access_time),
          ),
          child: Text('${time.hour}:${time.minute}'),
        ),
      ),
    );
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
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.face),
                  labelText: 'Nome',
                ),
                controller: _inputNomeGrupo,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do grupo.';
                  }
                  return null;
                },
                maxLength: 20,
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  _buildTimePickerField(context, true),
                  const SizedBox(width: 8.0),
                  _buildTimePickerField(context, false),
                ],
              ),
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
