import 'package:flutter/material.dart';
import '../widgets/build_input.dart';
import '../widgets/button_icon.dart';
import '../widgets/header.dart';
import '../controller/user_controller.dart';
import '../provider/user_provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final UserProvider userProvider = UserProvider();
  late final UserController ctlUserController;
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final TextEditingController _inputName = TextEditingController();
  final TextEditingController _inputEmail = TextEditingController();
  final TextEditingController _inputPhone = TextEditingController();
  final TextEditingController _inputPassword = TextEditingController();
  final TextEditingController _inputPasswordCheck = TextEditingController();

  @override
  void initState() {
    ctlUserController = UserController(provider: userProvider);
    super.initState();
  }

  void _clearInputs() {
    _inputName.clear();
    _inputEmail.clear();
    _inputPhone.clear();
    _inputPassword.clear();
    _inputPasswordCheck.clear();
  }

  void _handleSubmit() async {
    if (_formState.currentState!.validate()) {
      await ctlUserController.signUpUser(
        context,
        _inputName.text.toLowerCase(),
        _inputEmail.text.toLowerCase(),
        _inputPhone.text,
        _inputPassword.text,
        _inputPasswordCheck.text,
      );
      if (ctlUserController.errorMessage == 'Usuário criado com sucesso!') {
        _showSnackbar('Usuário criado com sucesso!', isError: false);
        _clearInputs();
      } else {
        _showSnackbar(ctlUserController.errorMessage!, isError: true);
      }
    }
  }

  void _showSnackbar(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: isError ? Colors.red : Colors.green,
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
                              return 'Digite seu celular';
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
                              return 'Digite sua senha';
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
