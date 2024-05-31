import 'package:app_atalaia/widgets/header.dart';
import 'package:app_atalaia/widgets/menu.dart';
import 'package:flutter/material.dart';
import '../widgets/button_icon.dart';
import 'success_screen.dart';
import '../screens/group_switch/dropdown_icons.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  late TextEditingController _inputNomeGrupo;
  late bool randomTime;
  late bool keepActive;
  late bool autoActivationTime;
  late IconData selectedIcon;

  @override
  void initState() {
    super.initState();
    _inputNomeGrupo = TextEditingController();
    randomTime = false;
    keepActive = false;
    autoActivationTime = false;
    selectedIcon = Icons.group;
  }

  @override
  void dispose() {
    _inputNomeGrupo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(title: 'Criar Grupo'),
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
              ),
              const SizedBox(height: 16.0),
              const Text('Selecione um Ícone:'),
              const SizedBox(height: 8.0),
              IconDropdownOptions.buildDropdown(
                value: selectedIcon,
                onChanged: (newValue) {
                  setState(() {
                    selectedIcon = newValue!;
                  });
                },
              ),
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
                labelText: 'Criar Grupo',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SuccessScreen(
                        message: 'Grupo Criado com sucesso',
                        alternativeRoute: '/group_switch',
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
