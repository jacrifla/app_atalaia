import 'package:flutter/material.dart';
import '../provider/user_provider.dart';
import '../controller/user_controller.dart';
import 'token_verification_screen.dart';
import '../widgets/header.dart';
import '../widgets/build_input.dart';
import '../widgets/button_icon.dart';

class RecoverScreen extends StatefulWidget {
  final String? email;

  const RecoverScreen({super.key, this.email});

  @override
  State<RecoverScreen> createState() => _RecoverScreenState();
}

class _RecoverScreenState extends State<RecoverScreen> {
  final UserProvider userProvider = UserProvider();
  late final UserController ctlUserController;

  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  late final TextEditingController _inputEmail;

  @override
  void initState() {
    super.initState();
    ctlUserController = UserController(provider: userProvider);
    _inputEmail = TextEditingController(text: widget.email ?? '');
  }

  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira seu e-mail';
    }
    return null;
  }

  void sendEmail() async {
    await ctlUserController.requestChangePassword(_inputEmail.text);
    if (ctlUserController.errorMessage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Email enviado com sucesso. Verifique seu email para o token.'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              TokenVerificationScreen(email: _inputEmail.text),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(ctlUserController.errorMessage!),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(title: 'Recuperação'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                children: [
                  const Text(
                    'Insira seu e-mail de cadastro.',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Form(
                    key: _formState,
                    child: BuildInput(
                      controller: _inputEmail,
                      labelText: 'Digite seu e-mail',
                      validator: _validateInput,
                    ),
                  ),
                ],
              ),
              ButtonIcon(
                onPressed: () {
                  if (_formState.currentState!.validate()) {
                    sendEmail();
                  }
                },
                icon: const Icon(Icons.check),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
