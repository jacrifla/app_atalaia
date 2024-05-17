// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

import '../../widgets/build_input.dart';
import '../../widgets/button_icon.dart';
import '../../widgets/header.dart';
import '../../widgets/menu.dart';
import '../success_screen.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  bool groupCommon = false;
  bool randomTime = false;
  bool keepActive = false;
  bool autoActivationTime = false;
  IconData selectedIcon = Icons.group;
  final TextEditingController _inputNomeGrupo = TextEditingController();

  // Lista de ícones disponíveis
  List<IconData> iconOptions = [
    Icons.group,
    Icons.home,
    Icons.living_rounded,
    Icons.kitchen,
    Icons.dry_cleaning,
    Icons.clean_hands,
    Icons.report_problem_rounded,
    Icons.cloud_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: 'Criar Grupo'),
      endDrawer: MenuDrawer(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BuildInput(
                icon: Icon(Icons.face),
                labelText: 'Nome',
                controller: _inputNomeGrupo,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do grupo.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Text('Selecione um Ícone:'),
              SizedBox(height: 8.0),
              DropdownButton<IconData>(
                value: selectedIcon,
                onChanged: (IconData? newValue) {
                  setState(() {
                    selectedIcon = newValue!;
                  });
                },
                items: iconOptions
                    .map<DropdownMenuItem<IconData>>((IconData icon) {
                  return DropdownMenuItem<IconData>(
                    value: icon,
                    child: Icon(icon),
                  );
                }).toList(),
              ),
              CheckboxListTile(
                title: Text('Horário Aleatório'),
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
                    Expanded(
                      child: Text('Manter Ativo Por'),
                    ),
                    SizedBox(
                      width: 50.0,
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Tempo'),
                        keyboardType: TextInputType.number,
                        initialValue: '1',
                      ),
                    ),
                    Text('hora(s)'),
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
                title: Text('Definir um Horário de Ativação Automática?'),
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
                        decoration: InputDecoration(labelText: 'De'),
                        initialValue: '10h',
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Até'),
                        initialValue: '11h',
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 30.0),
              ButtonIcon(
                labelText: 'Enviar',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SuccessScreen(
                        message: 'Grupo Criado com sucesso',
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

  void saveGroupAndReturnToGroupScreen() {
    Navigator.pop(context, {
      'groupName': _inputNomeGrupo.text,
      'groupIcon': selectedIcon,
      'groupCommon': groupCommon,
      'randomTime': randomTime,
      'keepActive': keepActive,
      'autoActivationTime': autoActivationTime,
    });
  }
}
