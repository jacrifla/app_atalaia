// ignore_for_file: prefer_const_constructors

import '../pages/recover_confirmation_page.dart';
import '../widgets/build_input.dart';
import '../widgets/button_icon.dart';
import 'package:flutter/material.dart';

class RecoverPage extends StatefulWidget {
  RecoverPage({Key? key}) : super(key: key);

  @override
  State<RecoverPage> createState() => _RecoverPageState();
}

class _RecoverPageState extends State<RecoverPage> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final TextEditingController _inputEmailCel = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recuperação',
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
