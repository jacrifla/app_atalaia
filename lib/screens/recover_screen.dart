// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

import 'recover_confirmation_screen.dart';
import '../widgets/header.dart';
import '../widgets/build_input.dart';
import '../widgets/button_icon.dart';
import '../utils.dart';

class RecoverPage extends StatefulWidget {
  const RecoverPage({super.key});

  @override
  State<RecoverPage> createState() => _RecoverPageState();
}

class _RecoverPageState extends State<RecoverPage> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final TextEditingController _inputEmailCel = TextEditingController();

  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira seu e-mail ou telefone.';
    }
    if (!isValidEmail(value) && !isValidPhoneNumber(value)) {
      return 'Por favor, insira um e-mail ou telefone válido.';
    }
    return null;
  }

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
                      validator: _validateInput,
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
