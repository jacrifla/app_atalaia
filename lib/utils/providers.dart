import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/group_controller.dart';
import '../provider/group_provider.dart';
import '../controller/switch_controller.dart';
import '../controller/user_controller.dart';
import '../provider/switch_provider.dart';
import '../provider/user_provider.dart';
import 'auth_provider.dart';

class MyAppProviders extends StatelessWidget {
  final Widget child;

  const MyAppProviders({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserController>(
          create: (_) => UserController(
            UserProvider(AuthProvider()),
            AuthProvider(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => GroupController(),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider<SwitchProvider>(
          create: (_) => SwitchProvider(),
        ),
        ChangeNotifierProvider<SwitchController>(
          create: (_) => SwitchController(),
        ),
        ChangeNotifierProvider<GroupController>(
          create: (_) => GroupController(),
        ),
        ChangeNotifierProvider<GroupProvider>(
          create: (_) => GroupProvider(),
        ),
      ],
      child: child,
    );
  }
}
