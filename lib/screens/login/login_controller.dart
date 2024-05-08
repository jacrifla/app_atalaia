// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';

import 'login_provider.dart';
import '../../screens/error_screen.dart';

class LoginController {
  final LoginProvider _loginProvider = LoginProvider();

  Future<void> loginUser(
      BuildContext context, String email, String password) async {
    try {
      Map<String, dynamic> loginResult =
          await _loginProvider.login(email, password);

      if (loginResult['status'] == 'success') {
        Navigator.pushNamed(context, '/home');
      } else {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ErrorScreen(
              message: 'Falha no login',
              errorDescription: loginResult['msg'],
              onOKPressed: () => Navigator.pop(context),
            ),
          ),
        );
      }
    } catch (error) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ErrorScreen(
            message: 'Error',
            errorDescription: 'Usuário não encontrado',
            onOKPressed: () => Navigator.pop(context),
          ),
        ),
      );
    }
  }
}
