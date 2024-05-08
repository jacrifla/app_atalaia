import 'package:flutter/material.dart';

import '../widgets/button_icon.dart';

class ErrorScreen extends StatelessWidget {
  final String message;
  final String errorDescription;
  final VoidCallback? onOKPressed;

  const ErrorScreen({
    super.key,
    required this.message,
    required this.errorDescription,
    this.onOKPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.warning_amber,
                size: 150,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 40),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
              const SizedBox(height: 20),
              Flexible(
                child: Text(
                  errorDescription,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 60),
              ButtonIcon(
                onPressed: onOKPressed,
                icon: const Icon(Icons.check),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
