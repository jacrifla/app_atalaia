import 'package:flutter/material.dart';

class BuildInput extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final Icon icon;
  final TextEditingController? controller;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const BuildInput({
    super.key,
    required this.labelText,
    this.hintText,
    this.icon = const Icon(Icons.account_circle_outlined),
    required this.controller,
    this.isPassword = false,
    this.validator,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          validator: validator,
          controller: controller,
          obscureText: isPassword,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            prefixIcon: icon,
          ),
        ),
        const SizedBox(height: 35),
      ],
    );
  }
}
