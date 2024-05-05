// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

import 'help_screen.dart';
import 'home_screen.dart';
import 'recover_screen.dart';
import 'signup_screen.dart';
import '../widgets/build_input.dart';
import '../widgets/build_row.dart';
import '../widgets/button_icon.dart';
import '../utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final TextEditingController _inputEmail = TextEditingController();
  final TextEditingController _inputPassword = TextEditingController();

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
    _clearTextFields();
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: [
                    Image.asset('assets/images/logo.png'),
                    SizedBox(height: 10),
                    Text(
                      'Projeto Atalaia'.toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'Montserrat Alternates',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                        isPassword: true,
                        controller: _inputPassword,
                        labelText: 'Senha',
                        hintText: '******',
                        icon: Icon(Icons.key_outlined),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BuildRow(
                          labelText: 'Criar Conta',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignupScreen(),
                              ),
                            );
                          },
                        ),
                        BuildRow(
                          labelText: 'Esqueci Minha Senha',
                          icon: Icon(Icons.person_search_outlined),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecoverScreen(),
                              ),
                            );
                          },
                        ),
                        BuildRow(
                          labelText: 'Preciso de Ajuda',
                          icon: Icon(Icons.question_mark_outlined),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HelpScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    ButtonIcon(
                      labelText: 'Entrar',
                      onPressed: () {
                        if (_formState.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        }
                      },
                      icon: Icon(Icons.check),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}