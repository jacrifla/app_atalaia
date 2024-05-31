import 'package:flutter/material.dart';

import '../utils/auth_provider.dart';
import '../widgets/build_input.dart';
import '../widgets/build_row.dart';
import '../widgets/button_icon.dart';
import '../utils/utils.dart';
import '../screens/user/login/login_controller.dart';
import '../screens/user/login/login_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final LoginProvider loginProvider;
  late final LoginController _loginController;
  final TextEditingController _inputEmail = TextEditingController();
  final TextEditingController _inputPassword = TextEditingController();
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loginProvider = LoginProvider(AuthProvider());
    loginProvider.initDio();
    _loginController = LoginController(loginProvider, AuthProvider());
    _clearTextFields();
  }

  @override
  void dispose() {
    _inputEmail.dispose();
    _inputPassword.dispose();
    super.dispose();
  }

  void _clearTextFields() {
    _inputEmail.clear();
    _inputPassword.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  children: [
                    Image.asset('assets/images/logo.png'),
                    const SizedBox(height: 10),
                    titleLogo(),
                  ],
                ),
                Form(
                  key: _formState,
                  child: Column(
                    children: [
                      BuildInput(
                        controller: _inputEmail,
                        keyboardType: TextInputType.emailAddress,
                        labelText: 'E-mail',
                        hintText: 'example@example.com',
                        icon: const Icon(Icons.account_circle_outlined),
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
                        isPassword: true,
                        controller: _inputPassword,
                        labelText: 'Senha',
                        hintText: '******',
                        icon: const Icon(Icons.key_outlined),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Digite sua senha';
                          }
                          if (value.length < 8) {
                            return 'Senha deve ter no mínimo 8 caracteres';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                ButtonIcon(
                  height: 50,
                  labelText: 'Entrar',
                  onPressed: () {
                    if (_formState.currentState!.validate()) {
                      _loginController.loginUser(
                        context,
                        _inputEmail.text.trim().toLowerCase(),
                        _inputPassword.text.trim(),
                      );
                    }
                  },
                  icon: const Icon(Icons.check),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BuildRow(
                            labelText: 'Criar Conta',
                            onTap: () =>
                                Navigator.pushNamed(context, '/signup'),
                          ),
                          BuildRow(
                            labelText: 'Esqueci Minha Senha',
                            icon: const Icon(Icons.person_search_outlined),
                            onTap: () =>
                                Navigator.pushNamed(context, '/recover'),
                          ),
                          BuildRow(
                            labelText: 'Preciso de Ajuda',
                            icon: const Icon(Icons.question_mark_outlined),
                            onTap: () => Navigator.pushNamed(context, '/help'),
                          ),
                        ],
                      ),
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

  Widget titleLogo() {
    return Text(
      'Projeto Atalaia'.toUpperCase(),
      style: const TextStyle(
        fontFamily: 'Montserrat Alternates',
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
