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
          if (icon != null) Icon(icon),
          if (icon != null) const SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      iconTheme: IconThemeData(
        color: Theme.of(context).colorScheme.onPrimary,
        size: 30,
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
  }
}
