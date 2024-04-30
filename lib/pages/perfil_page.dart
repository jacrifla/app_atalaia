// ignore_for_file: prefer_const_constructors

import 'package:app_atalaia/widgets/header.dart';
import 'package:flutter/material.dart';
import 'success_screen.dart';
import '../widgets/build_input.dart';
import '../widgets/button_icon.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({Key? key}) : super(key: key);

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final TextEditingController _inputEmail = TextEditingController();
  final TextEditingController _inputCel = TextEditingController();
  final TextEditingController _inputPassword = TextEditingController();
  final TextEditingController _inputNewPassword = TextEditingController();
  final TextEditingController _inputRepeatPassword = TextEditingController();

  void _navegarParaSucesso() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SuccessScreen(
          message: 'Senha alterada com sucesso',
          icon: Icons.check_circle_outline,
          onOKPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: 'Perfil'),
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
                          labelText: 'E-mail',
                          controller: _inputEmail,
                          errorText: 'Digite seu e-mail',
                        ),
                        BuildInput(
                          labelText: 'Celular',
                          icon: Icon(Icons.phone_outlined),
                          controller: _inputCel,
                          errorText: 'Digite seu celular',
                        ),
                        BuildInput(
                          labelText: 'Senha Atual',
                          icon: Icon(Icons.key_outlined),
                          isPassword: true,
                          controller: _inputPassword,
                          errorText: 'Digite sua senha',
                        ),
                        BuildInput(
                          labelText: 'Nova Senha',
                          icon: Icon(Icons.key_outlined),
                          isPassword: true,
                          controller: _inputNewPassword,
                          errorText: 'Digite sua nova senha',
                        ),
                        BuildInput(
                          labelText: 'Repita Sua Senha',
                          icon: Icon(Icons.key_outlined),
                          isPassword: true,
                          controller: _inputRepeatPassword,
                          errorText: 'Repita sua nova senha',
                        )
                      ],
                    )),
                ButtonIcon(
                  onPressed: () {
                    if (_formState.currentState!.validate()) {
                      _navegarParaSucesso();
                    }
                  },
                  icon: Icon(Icons.check),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
