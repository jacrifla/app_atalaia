import 'package:app_atalaia/screens/control/monitor_switch_screen.dart';
import 'package:flutter/material.dart';
import '../screens/group_switch/group_screen.dart';
import '../screens/guard/guard_screen.dart';
import '../screens/help/help_screen.dart';
import '../screens/home_screen.dart';
import '../screens/loading_screen.dart';
import '../screens/recover_confirmation_screen.dart';
import '../screens/recover_screen.dart';
import '../screens/switch/switch_create.dart';
import '../screens/switch/switch_screen.dart';
import '../screens/user/login/login_screen.dart';
import '../screens/user/perfil/perfil_screen.dart';
import '../screens/user/signup/signup_screen.dart';

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
