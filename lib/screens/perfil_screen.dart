// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

import '../widgets/header.dart';
import '../widgets/menu.dart';
import '../widgets/build_input.dart';
import '../widgets/button_icon.dart';
import 'success_screen.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final TextEditingController _inputNome = TextEditingController();
  final TextEditingController _inputEmail = TextEditingController();
  final TextEditingController _inputCel = TextEditingController();

  void _navegarParaSucesso() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SuccessScreen(
          message: 'Perfil alterado com sucesso',
          screen: '/perfil',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: 'Perfil'),
      endDrawer: MenuDrawer(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'Deseja alterar as configurações da sua conta de usuário?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Form(
                    key: _formState,
                    child: Column(
                      children: [
                        BuildInput(
                          labelText: 'Nome',
                          controller: _inputNome,
                        ),
                        BuildInput(
                          labelText: 'E-mail',
                          icon: Icon(Icons.email_outlined),
                          controller: _inputEmail,
                        ),
                        BuildInput(
                          labelText: 'Celular',
                          icon: Icon(Icons.phone_outlined),
                          controller: _inputCel,
                        ),
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonIcon(
                      backgroundColor:
                          Theme.of(context).colorScheme.onSecondary,
                      labelText: 'Mudar senha?',
                      onPressed: () {
                        if (_formState.currentState!.validate()) {
                          Navigator.pushNamed(context, '/recover_confirmation');
                        }
                      },
                    ),
                    ButtonIcon(
                      onPressed: () {
                        if (_formState.currentState!.validate()) {
                          _navegarParaSucesso();
                        }
                      },
                      labelText: 'Confirmar',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
