// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nova Senha',
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
                          labelText: 'Digite sua senha',
                          icon: Icon(Icons.key_outlined),
                          errorText: 'Digite sua senha',
                          //Senha fraca',
                        ),
                        BuildInput(
                          controller: _inputPasswordCheck,
                          labelText: 'Repita sua senha',
                          icon: Icon(Icons.key_outlined),
                          errorText: '* A senha não corresponde',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ButtonIcon(
                icon: Icon(Icons.check),
                onPressed: () {
                  if (_formState.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
