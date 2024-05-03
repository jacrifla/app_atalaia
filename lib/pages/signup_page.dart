// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app_atalaia/widgets/header.dart';

import '../utils.dart';
import 'home_page.dart';
import 'package:flutter/material.dart';
import '../widgets/build_input.dart';
import '../widgets/button_icon.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final TextEditingController _inputEmail = TextEditingController();
  final TextEditingController _inputCel = TextEditingController();
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
    _inputEmail.dispose();
    _inputCel.dispose();
    _inputPassword.dispose();
    _inputPasswordCheck.dispose();
    super.dispose();
  }

  void _clearTextFields() {
    _inputEmail.clear();
    _inputCel.clear();
    _inputPassword.clear();
    _inputPasswordCheck.clear();
  }

  @override
  Widget build(BuildContext context) {
    _clearTextFields();
    return Scaffold(
      appBar: Header(title: 'Criar Conta'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formState,
                    child: Column(
                      children: [
                        BuildInput(
                          controller: _inputEmail,
                          keyboardType: TextInputType.emailAddress,
                          labelText: 'E-mail',
                          hintText: 'example@example.com',
                          icon: Icon(Icons.account_circle_outlined),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Digite seu e-mail';
                            }
                            if (!isValidEmail(value)) {
                              return 'Digite um e-mail válido';
                            }
                            return null;
                          },
                        ),
                        BuildInput(
                          controller: _inputCel,
                          keyboardType: TextInputType.number,
                          labelText: 'Celular',
                          hintText: '(99) 99999-9999',
                          icon: Icon(Icons.phone_outlined),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Digite seu e-mail';
                            }
                            if (!isValidPhoneNumber(value)) {
                              return 'Digite um e-mail válido';
                            }
                            return null;
                          },
                        ),
                        Text(
                          'Crie uma senha forte combinando letras (minúsculas e maiúsculas), números e símbolos.',
                          style: TextStyle(fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        BuildInput(
                          isPassword: true,
                          controller: _inputPassword,
                          labelText: 'Digite sua senha',
                          hintText: '*********',
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
                          isPassword: true,
                          controller: _inputPasswordCheck,
                          labelText: 'Repita sua senha',
                          hintText: '*********',
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
                ),
              ),
              ButtonIcon(
                onPressed: _handleSubmit,
                icon: Icon(Icons.check),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
