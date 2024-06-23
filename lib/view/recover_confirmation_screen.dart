import 'package:flutter/material.dart';
import '../provider/user_provider.dart';
import '../controller/user_controller.dart';
import '../utils/routes.dart';
import '../widgets/header.dart';
import '../widgets/build_input.dart';
import '../widgets/button_icon.dart';

class RecoverConfirmationScreen extends StatefulWidget {
  final String email;
  final String token;

  const RecoverConfirmationScreen(
      {super.key, required this.email, required this.token});

  @override
  State<RecoverConfirmationScreen> createState() =>
      _RecoverConfirmationScreenState();
}

class _RecoverConfirmationScreenState extends State<RecoverConfirmationScreen> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final TextEditingController _inputPassword = TextEditingController();
  final TextEditingController _inputPasswordCheck = TextEditingController();

  final UserProvider userProvider = UserProvider();
  late final UserController ctlUserController;

  @override
  void initState() {
    super.initState();
    ctlUserController = UserController(provider: userProvider);
  }

  bool _arePasswordsEqual() {
    return _inputPassword.text == _inputPasswordCheck.text;
  }

  void _handleSubmit() async {
    if (!_arePasswordsEqual()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erro'),
          content: const Text('As senhas não correspondem.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    if (_formState.currentState!.validate()) {
      await ctlUserController.changePassword(
          widget.email, widget.token, _inputPassword.text);
      if (ctlUserController.errorMessage == null) {
        Navigator.pushNamed(context, AppRoutes.login);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(ctlUserController.errorMessage!)),
        );
      }
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
      appBar: const Header(title: 'Nova Senha'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Text(
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
                          controller: _inputPasswordCheck,
                          isPassword: true,
                          labelText: 'Repita sua senha',
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
                ],
              ),
              ButtonIcon(
                icon: const Icon(Icons.check),
                onPressed: _handleSubmit,
              )
            ],
          ),
        ),
      ),
    );
  }
}
