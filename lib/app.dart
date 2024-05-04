// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

import 'screens/perfil_screen.dart';
import 'screens/recover_confirmation_screen.dart';
import 'screens/login_screen.dart';
import 'screens/recover_screen.dart';
import 'screens/signup_screen.dart';
import 'theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Atalaia App',
      theme: AppTheme.lightTheme(),
      // theme: AppTheme.darkTheme(),
      routes: {
        '/': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/recover': (context) => RecoverPage(),
        '/recover_confirmation': (context) => const RecoverConfirmationPage(),
        '/perfil': (context) => const PerfilPage(),
      },
      initialRoute: '/',
    );
  }
}
