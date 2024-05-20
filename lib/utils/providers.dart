import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/switch/switch_controller.dart';
import '../screens/switch/switch_provider.dart';
import '../screens/user/perfil/perfil_controller.dart';
import 'auth_provider.dart';

class MyAppProviders extends StatelessWidget {
  final Widget child;

  const MyAppProviders({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserController>(create: (_) => UserController()),
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<SwitchProvider>(create: (_) => SwitchProvider()),
        ChangeNotifierProvider<SwitchController>(
            create: (_) => SwitchController()),
      ],
      child: child,
    );
  }
}
