import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget {
  final String labelText;
  final VoidCallback? onPressed;
  final Icon? icon;
  final Color? backgroundColor;
  final BorderSide? borderSide;
  final Color? color;
  final double? height;

  const ButtonIcon({
    super.key,
    this.labelText = '',
    this.onPressed,
    this.icon,
    this.backgroundColor,
    this.borderSide,
    this.color,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      label: Text(
        labelText,
      ),
      icon: icon ?? const SizedBox.shrink(),
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color?>(backgroundColor),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        side: WidgetStateProperty.all(borderSide ?? BorderSide.none),
        minimumSize: WidgetStateProperty.all(const Size(120, 50)),
      ),
    );
  }
}
