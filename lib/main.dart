import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'screens/switch/switch_provider.dart';
import 'screens/switch/switch_controller.dart';
import 'screens/user/user_controller.dart';
import 'utils/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserController>(create: (_) => UserController()),
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<SwitchProvider>(create: (_) => SwitchProvider()),
        ChangeNotifierProvider<SwitchController>(
            create: (_) => SwitchController()),
      ],
      child: const MyApp(),
    ),
  );
}
