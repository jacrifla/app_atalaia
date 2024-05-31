import 'package:app_atalaia/view/monitor_switch_screen.dart';
import 'package:flutter/material.dart';
import '../view/group_screen.dart';
import '../view/guard_screen.dart';
import '../view/help_screen.dart';
import '../view/home_screen.dart';
import '../view/loading_screen.dart';
import '../view/recover_confirmation_screen.dart';
import '../view/recover_screen.dart';
import '../view/switch_create_screen.dart';
import '../view/switch_screen.dart';
import '../view/login_screen.dart';
import '../view/perfil_screen.dart';
import '../view/signup_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/': (context) => const LoginScreen(),
      '/group_switch': (context) => const GroupScreen(),
      '/help': (context) => const HelpScreen(),
      '/home': (context) => const HomeScreen(),
      '/perfil': (context) => const PerfilScreen(),
      '/recover': (context) => const RecoverScreen(),
      '/recover_confirmation': (context) => const RecoverConfirmationScreen(),
      '/signup': (context) => const SignupScreen(),
      '/switch': (context) => const SwitchScreen(),
      '/switch_create': (context) => SwitchCreateScreen(),
      '/guard': (context) => GuardManagementScreen(),
      '/loading': (context) => const LoadingScreen(),
      '/monitor': (context) => const MonitorSwitchScreen()
    };
  }
}
