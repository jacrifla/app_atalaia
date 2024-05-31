import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData? icon;

  const Header({
    super.key,
    required this.title,
    this.icon,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Expanded(
            child: Text(title),
          ),
          if (icon != null) Icon(icon),
        ],
      ),
    );
  }
}
