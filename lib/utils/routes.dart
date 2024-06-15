import 'package:flutter/material.dart';

import '../model/group_model.dart';
import '../model/switch_model.dart';
import '../view/group_create_screen.dart';
import '../view/group_edit_screen.dart';
import '../view/group_screen.dart';
import '../view/guard_screen.dart';
import '../view/help_screen.dart';
import '../view/home_screen.dart';
import '../view/loading_screen.dart';
import '../view/monitor_switch_screen.dart';
import '../view/recover_confirmation_screen.dart';
import '../view/recover_screen.dart';
import '../view/select_switches_screen.dart';
import '../view/switch_create_screen.dart';
import '../view/switch_edit_screen.dart';
import '../view/switch_screen.dart';
import '../view/login_screen.dart';
import '../view/perfil_screen.dart';
import '../view/signup_screen.dart';
// import '../view/monitor_switch_screen.dart';
// import '../view/recover_confirmation_screen.dart';
// import '../view/recover_screen.dart';

class AppRoutes {
  static const String guard = '/guard';
  static const String groupEdit = '/group_edit';
  static const String groupCreate = '/group_create';
  static const String groupScreen = '/group_screen';
  static const String help = '/help';
  static const String home = '/home';
  static const String loading = '/loading';
  static const String login = '/';
  static const String monitorSwitch = '/monitor_switch';
  static const String recover = '/recover';
  static const String recoverConfirmation = '/recover_confirmation';
  static const String signUp = '/register';
  static const String switchScreen = '/switch_screen';
  static const String switchCreate = '/switch_create';
  static const String switchEdit = '/switch_edit';
  static const String userProfile = '/profile';
  static const String selectSwitch = '/select_switch';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      guard: (context) => const GuardScreen(),
      groupEdit: (context) => EditGroupScreen(groupInfo: GroupModel()),
      groupCreate: (context) => const CreateGroupScreen(),
      groupScreen: (context) => const GroupScreen(),
      help: (context) => const HelpScreen(),
      home: (context) => const HomeScreen(),
      loading: (context) => const LoadingScreen(),
      login: (context) => const LoginScreen(),
      monitorSwitch: (context) => const MonitorSwitchScreen(),
      recover: (context) => const RecoverScreen(),
      recoverConfirmation: (context) => const RecoverConfirmationScreen(),
      signUp: (context) => const SignupScreen(),
      switchScreen: (context) => const SwitchScreen(),
      switchCreate: (context) => const SwitchCreateScreen(),
      switchEdit: (context) => EditSwitchScreen(switchModel: SwitchModel()),
      userProfile: (context) => const PerfilScreen(),
      selectSwitch: (context) => const SwitchSelectionScreen(),
    };
  }
}
