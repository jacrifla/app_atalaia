import 'package:flutter/material.dart';

import '../utils/routes.dart';
import '../widgets/button_icon.dart';
import '../widgets/header.dart';
import '../widgets/menu.dart';
import '../model/group_model.dart';
import '../provider/group_provider.dart';
import '../controller/group_controller.dart';
import 'error_screen.dart';
import 'success_screen.dart';

class EditGroupScreen extends StatefulWidget {
  final GroupModel groupInfo;

  const EditGroupScreen({super.key, required this.groupInfo});

  @override
  State<EditGroupScreen> createState() => _EditGroupScreenState();
}

class _EditGroupScreenState extends State<EditGroupScreen> {
  final GroupProvider groupProvider = GroupProvider();
  late final GroupController ctlGroupController;
  late bool keepActive;
  late bool autoActivationTime;
  final TextEditingController _inputNomeGrupo = TextEditingController();
  final TextEditingController _inputScheduleStart = TextEditingController();
  final TextEditingController _inputScheduleEnd = TextEditingController();
  final TextEditingController _inputActiveHours = TextEditingController();
  TimeOfDay fromTime = TimeOfDay.now();
  TimeOfDay toTime = TimeOfDay.now();

  @override
  void initState() {
    ctlGroupController = GroupController(groupProvider);
    _inputNomeGrupo.text = widget.groupInfo.groupName ?? "";
    _inputScheduleStart.text = widget.groupInfo.scheduleStart ?? "";
    _inputScheduleEnd.text = widget.groupInfo.scheduleEnd ?? "";
    _inputActiveHours.text = widget.groupInfo.keepFor ?? "";
    keepActive = widget.groupInfo.keepFor != null;
    autoActivationTime = widget.groupInfo.scheduleActive!;
    super.initState();
  }

  @override
  void dispose() {
    _inputNomeGrupo.dispose();
    _inputScheduleStart.dispose();
    _inputScheduleEnd.dispose();
    _inputActiveHours.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    final updatedGroup = {
      'group_id': widget.groupInfo.groupId,
      'name': _inputNomeGrupo.text,
      'schedule_active': autoActivationTime,
      'schedule_start': _inputScheduleStart.text,
      'schedule_end': _inputScheduleEnd.text,
      'keep_for': keepActive ? _inputActiveHours.text : null,
    };

    try {
      await ctlGroupController.updateGroupInfo(updatedGroup);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SuccessScreen(
            message: 'Alterações salvas com sucesso',
            screen: AppRoutes.groupScreen,
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
                maxLength: 24,
              ),
              const SizedBox(height: 16.0),
              CheckboxListTile(
                title: const Text('Ativo por quantas horas?'),
                value: keepActive,
                onChanged: (value) {
                  setState(() {
                    keepActive = value ?? false;
                    autoActivationTime = !keepActive;
                  });
                },
              ),
              if (keepActive)
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Ativo por (horas)'),
                  controller: _inputActiveHours,
                ),
              CheckboxListTile(
                title: const Text('Definir um Horário de Ativação Automática?'),
                value: autoActivationTime,
                onChanged: (value) {
                  setState(() {
                    autoActivationTime = value ?? false;
                    keepActive = !autoActivationTime;
                  });
                },
              ),
              if (autoActivationTime)
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
