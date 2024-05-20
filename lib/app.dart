import 'package:app_atalaia/utils/routes.dart';
import 'package:flutter/material.dart';
import 'theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Atalaia App',
      theme: AppTheme.lightTheme(),
      routes: AppRoutes.getRoutes(),
      initialRoute: '/',
    );
  }
}
