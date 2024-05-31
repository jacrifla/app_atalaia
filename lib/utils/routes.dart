import 'package:flutter/material.dart';
import '../view/group_create_screen.dart';
import '../view/group_screen.dart';
import '../view/guard_screen.dart';
import '../view/help_screen.dart';
import '../view/home_screen.dart';
import '../view/loading_screen.dart';
import '../view/switch_create_screen.dart';
import '../view/switch_screen.dart';
import '../view/login_screen.dart';
import '../view/perfil_screen.dart';
import '../view/signup_screen.dart';
// import '../view/monitor_switch_screen.dart';
// import '../view/recover_confirmation_screen.dart';
// import '../view/recover_screen.dart';

class AppRoutes {
  static const String home = '/home';
  static const String login = '/';
  static const String signUp = '/register';
  static const String userProfile = '/profile';
  static const String help = '/help';
  static const String loading = '/loading';
  static const String groupScreen = '/group_screen';
  static const String groupCreate = '/group_create';
  static const String groupEdit = '/group_edit';
  static const String switchScreen = '/switch_screen';
  static const String switchCreate = '/switch_create';
  static const String switchEdit = '/switch_edit';
  static const String guard = '/guard';
  static const String errorScreen = '/error_screen';
  static const String successScreen = '/success_screen';
  static const String confirmScreen = '/confirm_screen';
  static const String recover = '/recover';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => const HomeScreen(),
      login: (context) => const LoginScreen(),
      signUp: (context) => const SignupScreen(),
      help: (context) => const HelpScreen(),
      userProfile: (context) => const PerfilScreen(),
      loading: (context) => const LoadingScreen(),
      groupScreen: (context) => const GroupScreen(),
      groupCreate: (context) => const CreateGroupScreen(),
      switchScreen: (context) => const SwitchScreen(),
      switchCreate: (context) => SwitchCreateScreen(),
      guard: (context) => GuardManagementScreen(),
      // switchEdit: (context) => EditSwitchScreen(),
      // groupEdit: (context) => EditGroupScreen(),
      // errorScreen: (context) => const ErrorScreen(),
      // successScreen: (context) => const SuccessScreen(),
      // confirmScreen: (context) => const ConfirmationScreen(),
    };
  }
}
