// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'home_page.dart';
import 'package:flutter/material.dart';
import '../widgets/build_input.dart';
import '../widgets/button_icon.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Criar Conta',
          style: TextStyle(
              color: Color(0xFFF5F5F5),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Color(0xFFF5F5F5), size: 30),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Form(
                  key: _formState,
                  child: Column(
                    children: [
                      BuildInput(
                        controller: _inputEmail,
                        labelText: 'E-mail',
                        hintText: 'example@example.com',
                        icon: Icon(Icons.account_circle_outlined),
                        errorText: 'Digite seu e-mail',
                        // 'E-mail não encontrado' -> Se nao encontrar no banco de dados
                      ),
                      BuildInput(
                        controller: _inputCel,
                        labelText: 'Celular',
                        hintText: '(99) 99999-9999',
                        icon: Icon(Icons.phone_outlined),
                        errorText: 'Digite seu número',
                        // 'Número já cadastrado',
                      ),
                      Text(
                          'Crie uma senha forte combinando letras (minúsculas e maiúsculas), números e símbolos.'),
                      BuildInput(
                        isPassword: true,
                        controller: _inputPassword,
                        labelText: 'Digite sua senha',
                        hintText: '*********',
                        icon: Icon(Icons.key_outlined),
                        errorText: 'Digite sua senha',
                        // errorText: 'Senha fraca',
                      ),
                      BuildInput(
                        isPassword: true,
                        controller: _inputPasswordCheck,
                        labelText: 'Repita sua senha',
                        hintText: '*********',
                        icon: Icon(Icons.key_outlined),
                        errorText: 'A senha não corresponde',
                      ),
                    ],
                  ),
                ),
                ButtonIcon(
                  onPressed: _handleSubmit,
                  icon: Icon(Icons.check),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
