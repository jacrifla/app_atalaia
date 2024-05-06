import 'package:flutter/material.dart';

import '../../utils.dart';
import '../../widgets/build_input.dart';
import '../../widgets/button_icon.dart';
import '../../widgets/header.dart';
import 'signup_controller.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final SignupController _signupController = SignupController();
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final TextEditingController _inputName = TextEditingController();
  final TextEditingController _inputEmail = TextEditingController();
  final TextEditingController _inputPhone = TextEditingController();
  final TextEditingController _inputPassword = TextEditingController();
  final TextEditingController _inputPasswordCheck = TextEditingController();

  bool _arePasswordsEqual() {
    return _inputPassword.text == _inputPasswordCheck.text;
  }

  void _clearInputs() {
    _inputName.clear();
    _inputEmail.clear();
    _inputPhone.clear();
    _inputPassword.clear();
    _inputPasswordCheck.clear();
  }

  void _handleSubmit() async {
    if (!_arePasswordsEqual()) {
      _showErrorDialog('As senhas não correspondem.');
      return;
    }

    if (_formState.currentState!.validate()) {
      _formState.currentState!.save();
      final response = await _signupController.createUser(
        _inputName.text,
        _inputEmail.text,
        _inputPhone.text,
        _inputPassword.text,
      );
      if (response['status'] == 'success') {
        _showSuccessSnackBar('Usuário criado com sucesso!');
        _clearInputs();
        Navigator.pushNamed(context, '/');
      } else {
        _showErrorSnackBar(response['message']);
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Erro'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.green,
    ));
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.red,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(title: 'Criar Conta'),
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
                          controller: _inputName,
                          keyboardType: TextInputType.emailAddress,
                          labelText: 'Nome',
                          hintText: 'John Doe',
                          icon: const Icon(Icons.account_circle_outlined),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Digite seu nome';
                            }
                            return null;
                          },
                        ),
                        BuildInput(
                          controller: _inputEmail,
                          keyboardType: TextInputType.emailAddress,
                          labelText: 'E-mail',
                          hintText: 'example@example.com',
                          icon: const Icon(Icons.email_outlined),
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
                          controller: _inputPhone,
                          keyboardType: TextInputType.number,
                          labelText: 'Celular',
                          hintText: '(99) 99999-9999',
                          icon: const Icon(Icons.phone_outlined),
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
                        const Text(
                          'Crie uma senha forte combinando letras (minúsculas e maiúsculas), números e símbolos.',
                          style: TextStyle(fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        BuildInput(
                          isPassword: true,
                          controller: _inputPassword,
                          labelText: 'Digite sua senha',
                          hintText: '*********',
                          icon: const Icon(Icons.key_outlined),
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
                          icon: const Icon(Icons.key_outlined),
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
                icon: const Icon(Icons.check),
              ),
            ],
          ),
        ),
      ),
    );
  }
}