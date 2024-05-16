// ignore_for_file: use_build_context_synchronously, avoid_print
import 'package:flutter/material.dart';

import '../../utils/auth_provider.dart';
import '../../screens/error_screen.dart';
import 'login_provider.dart';

class LoginController {
  final LoginProvider _loginProvider;
  final AuthProvider _authProvider;

  LoginController(
    this._loginProvider,
    this._authProvider,
  );

  Future<void> loginUser(
      BuildContext context, String email, String password) async {
    try {
      await _loginProvider.login(email, password);
      print('UUID após o login: ${_authProvider.userId}');

      Navigator.pushNamed(context, '/loading');
    } catch (error) {
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
