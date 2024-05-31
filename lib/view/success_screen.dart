// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import '../widgets/button_icon.dart';

class SuccessScreen extends StatelessWidget {
  final String message;
  final String? screen;
  final String? alternativeRoute;

  const SuccessScreen({
    super.key,
    required this.message,
    this.screen,
    this.alternativeRoute,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.check_circle_outline_rounded,
                  size: 250,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 40),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 120),
                ButtonIcon(
                  height: 50,
                  onPressed: () {
                    if (alternativeRoute != null) {
                      Navigator.pushNamed(context, alternativeRoute!);
                    } else {
                      Navigator.popUntil(
                        context,
                        ModalRoute.withName(screen!),
                      );
                    }
                  },
                  labelText: 'Voltar',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
