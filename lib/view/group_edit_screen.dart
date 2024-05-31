import 'package:flutter/material.dart';

import '../widgets/build_input.dart';
import '../widgets/button_icon.dart';
import '../widgets/header.dart';
import '../widgets/menu.dart';
import 'success_screen.dart';
import '../model/group_model.dart';

class EditGroupScreen extends StatefulWidget {
  final GroupModel groupInfo;

  const EditGroupScreen({super.key, required this.groupInfo});

  @override
  State<EditGroupScreen> createState() => _EditGroupScreenState();
}

class _EditGroupScreenState extends State<EditGroupScreen> {
  late TextEditingController _inputNomeGrupo;
  late bool randomTime;
  late bool keepActive;
  late bool autoActivationTime;
  late IconData selectedIcon;

  @override
  void initState() {
    super.initState();
    _inputNomeGrupo = TextEditingController(text: widget.groupInfo.groupName);
    randomTime = widget.groupInfo.randomTime;
    keepActive = widget.groupInfo.keepActive;
    autoActivationTime = widget.groupInfo.autoActivationTime;
    selectedIcon = widget.groupInfo.groupIcon;
  }

  @override
  void dispose() {
    _inputNomeGrupo.dispose();
    super.dispose();
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
              ),
              const SizedBox(height: 16.0),
              const Text('Selecione um Ícone:'),
              const SizedBox(height: 8.0),
              // Aqui você pode adicionar o dropdown de ícones
              CheckboxListTile(
                title: const Text('Horário Aleatório'),
                value: randomTime,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) {
                  setState(() {
                    randomTime = value ?? true;
                  });
                },
              ),
              CheckboxListTile(
                title: Row(
                  children: [
                    const Expanded(
                      child: Text('Manter Ativo Por'),
                    ),
                    SizedBox(
                      width: 50.0,
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: 'Tempo'),
                        keyboardType: TextInputType.number,
                        initialValue: '1',
                      ),
                    ),
                    const Text('hora(s)'),
                  ],
                ),
                controlAffinity: ListTileControlAffinity.leading,
                value: keepActive,
                onChanged: (value) {
                  setState(() {
                    keepActive = value ?? true;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Definir um Horário de Ativação Automática?'),
                value: autoActivationTime,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) {
                  setState(() {
                    autoActivationTime = value ?? true;
                  });
                },
              ),
              if (autoActivationTime)
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: 'De'),
                        initialValue: '10h',
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: 'Até'),
                        initialValue: '11h',
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 30.0),
              ButtonIcon(
                labelText: 'Salvar Alterações',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SuccessScreen(
                        message: 'Alterações salvas com sucesso',
                        screen: '/group_switch',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
