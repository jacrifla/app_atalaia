import 'package:flutter/material.dart';
import '../utils/routes.dart';
import '../widgets/button_icon.dart';
import '../widgets/header_screen.dart';
import '../model/group_model.dart';
import '../provider/group_provider.dart';
import '../controller/group_controller.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  late final GroupModel groupModel;
  final GroupProvider groupProvider = GroupProvider();
  late final GroupController ctlGroupController;
  final TextEditingController _inputGroupName = TextEditingController();
  bool autoActivationTime = false;
  TimeOfDay fromTime = TimeOfDay.now();
  TimeOfDay toTime = TimeOfDay.now();

  @override
  void initState() {
    ctlGroupController = GroupController(provider: groupProvider);
    groupModel = GroupModel();
    super.initState();
  }

  @override
  void dispose() {
    _inputGroupName.dispose();
    super.dispose();
  }

  Future<void> _createGroup(BuildContext context) async {
    try {
      await ctlGroupController.createGroup(
        _inputGroupName.text.toLowerCase(),
        true,
        autoActivationTime,
        groupModel.formatTimeOfDayToString(fromTime),
        groupModel.formatTimeOfDayToString(toTime),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Grupo Criado com sucesso'),
          backgroundColor: Colors.green,
        ),
      );
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushNamed(context, AppRoutes.groupScreen);
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao criar grupo: $error'),
          backgroundColor: Colors.red,
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
        } else {
          toTime = picked;
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
    return HeaderScreen(
      title: 'Criar Grupo',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextFormField(
                controller: _inputGroupName,
                decoration: const InputDecoration(
                  icon: Icon(Icons.group),
                  labelText: 'Nome',
                ),
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
                  const SizedBox(width: 8),
                  _buildTimePickerField(context, false),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: ButtonIcon(
            labelText: 'Criar Grupo',
            onPressed: () => _createGroup(context),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
