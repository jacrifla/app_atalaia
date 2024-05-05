// ignore_for_file: prefer_const_constructors
import 'package:app_atalaia/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

import 'screens/help_screen.dart';
import 'screens/home_screen.dart';
import 'screens/perfil_screen.dart';
import 'screens/recover_confirmation_screen.dart';
// import 'screens/login_screen.dart';
import 'screens/recover_screen.dart';
// import 'screens/signup_screen.dart';
import 'screens/signup/signup_screen.dart';
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
        '/': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/signup': (context) => SignupScreen(),
        '/recover': (context) => RecoverScreen(),
        '/recover_confirmation': (context) => const RecoverConfirmationScreen(),
        '/perfil': (context) => const PerfilScreen(),
        '/help': (context) => HelpScreen(),
      },
      initialRoute: '/',
    );
  }
}
