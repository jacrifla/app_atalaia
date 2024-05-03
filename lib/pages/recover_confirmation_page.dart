// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app_atalaia/widgets/header.dart';

import '../widgets/build_input.dart';
import '../widgets/button_icon.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class RecoverConfirmationPage extends StatefulWidget {
  const RecoverConfirmationPage({Key? key}) : super(key: key);

  @override
  State<RecoverConfirmationPage> createState() =>
      _RecoverConfirmationPageState();
}

class _RecoverConfirmationPageState extends State<RecoverConfirmationPage> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final TextEditingController _inputPassword = TextEditingController();
  final TextEditingController _inputPasswordCheck = TextEditingController();

  bool _arePasswordsEqual() {
    return _inputPassword.text == _inputPasswordCheck.text;
  }

  void _handleSubmit() {
    if (!_arePasswordsEqual()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Erro'),
          content: Text('As senhas não correspondem.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    if (_formState.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _inputPassword.dispose();
    _inputPasswordCheck.dispose();
    super.dispose();
  }

  void _clearTextFields() {
    _inputPassword.clear();
    _inputPasswordCheck.clear();
  }

  @override
  Widget build(BuildContext context) {
    _clearTextFields();
    return Scaffold(
      appBar: Header(title: 'Nova Senha'),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Crie uma nova senha que contenha combinação de letras (minúsculas e maiúsculas), números e símbolos.',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Form(
                    key: _formState,
                    child: Column(
                      children: [
                        BuildInput(
                          controller: _inputPassword,
                          isPassword: true,
                          labelText: 'Digite sua senha',
                          icon: Icon(Icons.key_outlined),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '* Digite sua senha';
                            }
                            if (value.length < 8) {
                              return '* Senha deve ter no mínimo 8 caracteres';
                            }
                            return null;
                          },
                        ),
                        BuildInput(
                          controller: _inputPasswordCheck,
                          isPassword: true,
                          labelText: 'Repita sua senha',
                          icon: Icon(Icons.key_outlined),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '* Digite sua senha';
                            }
                            if (value.length < 8) {
                              return '* Senha deve ter no mínimo 8 caracteres';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ButtonIcon(
                icon: Icon(Icons.check),
                onPressed: _handleSubmit,
              )
            ],
          ),
        ),
      ),
    );
  }
}
