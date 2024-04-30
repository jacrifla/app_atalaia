// ignore_for_file: prefer_const_constructors

import 'package:app_atalaia/widgets/header.dart';

import '../pages/recover_confirmation_page.dart';
import '../widgets/build_input.dart';
import '../widgets/button_icon.dart';
import 'package:flutter/material.dart';

class RecoverPage extends StatefulWidget {
  const RecoverPage({Key? key}) : super(key: key);

  @override
  State<RecoverPage> createState() => _RecoverPageState();
}

class _RecoverPageState extends State<RecoverPage> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final TextEditingController _inputEmailCel = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: 'Recuperação'),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                children: [
                  Text(
                    'Insira seu e-mail ou telefone de cadastro.',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Form(
                    key: _formState,
                    child: BuildInput(
                      controller: _inputEmailCel,
                      labelText: 'E-mail ou telefone',
                      errorText: 'Digite o e-mail / telefone',
                      // O e-mail / telefone não foi encontrado
                    ),
                  ),
                ],
              ),
              ButtonIcon(
                onPressed: () {
                  if (_formState.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecoverConfirmationPage(),
                      ),
                    );
                  }
                },
                icon: Icon(Icons.check),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
