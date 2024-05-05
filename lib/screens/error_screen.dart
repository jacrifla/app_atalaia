// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../widgets/button_icon.dart';

class ErrorScreen extends StatelessWidget {
  final String message;
  final String errorNumber;
  final String errorDescription;
  final VoidCallback? onOKPressed;

  const ErrorScreen({
    super.key,
    required this.message,
    required this.errorNumber,
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
                Icons.priority_high_rounded,
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
              SizedBox(height: 20),
              // Erro
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.warning_amber,
                    color: Theme.of(context).colorScheme.error,
                    size: 30,
                  ),
                  SizedBox(width: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Erro: ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          SizedBox(width: 20),
                          Text(
                            errorNumber,
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        errorDescription,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  )
                ],
              ),

              const SizedBox(height: 60),
              ButtonIcon(
                onPressed: onOKPressed,
                icon: Icon(Icons.check),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
