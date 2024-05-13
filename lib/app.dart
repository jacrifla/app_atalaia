// ignore_for_file: prefer_const_constructors
import 'package:app_atalaia/screens/guard/guard_screen.dart';
import 'package:flutter/material.dart';

import 'screens/help/help_screen.dart';
import 'screens/home_screen.dart';
import 'screens/perfil_screen.dart';
import 'screens/recover_confirmation_screen.dart';
import 'screens/login/login_screen.dart';
import 'screens/recover_screen.dart';
import 'screens/signup/signup_screen.dart';
import 'screens/switch/switch_create.dart';
import 'screens/switch/switch_screen.dart';
import 'screens/group_switch/group_screen.dart';
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
        '/group_switch': (context) => GroupScreen(),
        '/help': (context) => HelpScreen(),
        '/home': (context) => HomeScreen(),
        '/perfil': (context) => PerfilScreen(),
        '/recover': (context) => RecoverScreen(),
        '/recover_confirmation': (context) => RecoverConfirmationScreen(),
        '/signup': (context) => SignupScreen(),
        '/switch': (context) => SwitchScreen(),
        '/switch_create': (context) => SwitchCreateScreen(),
        '/guard': (context) => GuardManagementScreen(),
      },

      initialRoute: '/',
    );
  }
}
