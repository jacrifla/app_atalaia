import 'package:flutter/material.dart';

import 'login_provider.dart';

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
        print('Login failed: ${loginResult['msg']}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
