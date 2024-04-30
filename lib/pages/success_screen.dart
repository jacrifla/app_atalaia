import 'package:flutter/material.dart';
import '../widgets/button_icon.dart';

class SuccessScreen extends StatelessWidget {
  final String message;
  final IconData icon;
  final VoidCallback? onOKPressed;

  const SuccessScreen({
    Key? key,
    required this.message,
    required this.icon,
    this.onOKPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Icon(
                icon,
                size: 150,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(height: 40),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 60),
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
