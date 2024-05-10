// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';

import '../../utils/auth_provider.dart';
import 'login_provider.dart';
import '../../screens/error_screen.dart';

class LoginController {
  final LoginProvider _loginProvider;
  final AuthProvider _authProvider;

  LoginController(this._loginProvider, this._authProvider);

  Future<void> loginUser(
      BuildContext context, String email, String password) async {
    try {
      // Chama o método de login do LoginProvider
      await _loginProvider.login(email, password);
      print('UUID após o login: ${_authProvider.userId}');

      // Depois de logar com sucesso, vai para a tela principal
      Navigator.pushNamed(context, '/home');
    } catch (error) {
      // Em caso de erro, vai exibir uma mensagem de erro
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ErrorScreen(
            message: 'Erro no login',
            errorDescription: error.toString(),
            onOKPressed: () => Navigator.pop(context),
          ),
        ),
      );
    }
  }
}
