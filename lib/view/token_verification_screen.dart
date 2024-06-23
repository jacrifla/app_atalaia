import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/build_input.dart';
import '../widgets/button_icon.dart';
import 'recover_confirmation_screen.dart';

class TokenVerificationScreen extends StatefulWidget {
  final String email;

  const TokenVerificationScreen({super.key, required this.email});

  @override
  State<TokenVerificationScreen> createState() =>
      _TokenVerificationScreenState();
}

class _TokenVerificationScreenState extends State<TokenVerificationScreen> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final TextEditingController _inputToken = TextEditingController();

  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira o token de verificação';
    }
    return null;
  }

  void _handleSubmit() {
    if (_formState.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RecoverConfirmationScreen(
            email: widget.email,
            token: _inputToken.text,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _inputToken.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: 'Verificação de Token'),
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
                    'Insira o token de verificação enviado para o seu e-mail.',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Form(
                    key: _formState,
                    child: BuildInput(
                      controller: _inputToken,
                      labelText: 'Digite o token',
                      validator: _validateInput,
                    ),
                  ),
                ],
              ),
              ButtonIcon(
                onPressed: _handleSubmit,
                icon: Icon(Icons.check),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
