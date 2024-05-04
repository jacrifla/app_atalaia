// ignore_for_file: prefer_const_constructors

import 'pages/perfil_page.dart';
import 'package:flutter/material.dart';
import 'pages/recover_confirmation_page.dart';
import 'theme.dart';
import 'pages/login_page.dart';
import 'pages/recover_page.dart';
import 'pages/signup_page.dart';

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
