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
    return SizedBox(
      height: height,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        label: Text(
          labelText,
        ),
        icon: icon ?? const SizedBox.shrink(),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          side: MaterialStateProperty.all(borderSide ?? BorderSide.none),
        ),
      ),
    );
  }
}
