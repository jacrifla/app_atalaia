import 'package:flutter/material.dart';
import '../widgets/button_icon.dart';

class ConfirmationScreen extends StatelessWidget {
  final String question;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  const ConfirmationScreen({
    super.key,
    required this.question,
    this.onConfirm,
    this.onCancel,
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
                Icons.question_mark_rounded,
                size: 150,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 40),
              Text(
                question,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ButtonIcon(
                    onPressed: onCancel,
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 20),
                  ButtonIcon(
                    onPressed: onConfirm,
                    icon: const Icon(Icons.check),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
