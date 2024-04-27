import 'package:flutter/material.dart';

class BuildInput extends StatelessWidget {
  final String labelText;
  final String? errorText;
  final String? hintText;
  final Icon icon;
  final TextEditingController? controller;
  final bool isPassword;
  final String? Function(String?)? validator;

  const BuildInput({
    Key? key,
    required this.labelText,
    this.errorText,
    this.hintText,
    this.icon = const Icon(Icons.account_circle_outlined),
    required this.controller,
    this.isPassword = false,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return errorText;
            }
            return null;
          },
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            prefixIcon: icon,
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
