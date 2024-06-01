import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/user_controller.dart';
import '../utils/utils.dart';
import '../widgets/build_input.dart';
import '../widgets/button_icon.dart';
import '../widgets/header.dart';
import '../view/success_screen.dart';
import '../view/error_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
    final userController = Provider.of<UserController>(context, listen: false);

    if (!_arePasswordsEqual()) {
      _showErrorDialog('Erro', 'As senhas não correspondem.');
      return;
    }

    if (_formState.currentState!.validate()) {
      _formState.currentState!.save();
      final response = await userController.createUser(
        _inputName.text.toLowerCase(),
        _inputEmail.text.toLowerCase(),
        _inputPhone.text,
        _inputPassword.text,
      );
      if (response['status'] == 'success') {
        _showSuccessScreen('Usuário criado com sucesso!');
        _clearInputs();
      } else {
        if (response['message'] != null) {
          _showErrorDialog('Erro', response['message']);
        } else {
          _showErrorDialog('Erro', 'Ocorreu um erro desconhecido.');
        }
      }
    }
  }

  void _showErrorDialog(String message, String errorDescription) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ErrorScreen(
          message: message,
          errorDescription: errorDescription,
          onOKPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }

  void _showSuccessScreen(String message) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SuccessScreen(
          message: message,
          screen: '/',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(title: 'Criar Conta'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                labelText: 'Criar Conta',
                onPressed: _handleSubmit,
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
