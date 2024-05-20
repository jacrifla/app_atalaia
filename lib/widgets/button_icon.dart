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
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final defaultColor = Theme.of(context).colorScheme.onPrimary;
    return SizedBox(
      height: height,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        label: Text(
          labelText,
          style: TextStyle(color: color ?? defaultColor),
        ),
        icon: icon ?? const SizedBox.shrink(),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
            backgroundColor ?? Theme.of(context).colorScheme.primary,
          ),
          iconColor: MaterialStateProperty.all<Color>(color ?? defaultColor),
          side: MaterialStateProperty.all(borderSide ?? BorderSide.none),
        ),
      ),
    );
  }
}
