// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  void logout(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        // Espaçamento no topo do Drawer
        SizedBox(height: 82),
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: screenHeight * 0.6,
          color: Theme.of(context).colorScheme.background,
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  'Menu',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ItemMenu(
                label: 'Home',
                icon: Icon(Icons.home_outlined),
                onTap: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
              ItemMenu(
                label: 'Gerenciar Grupos',
                icon: Icon(Icons.tune),
                onTap: () {
                  Navigator.pushNamed(context, '/group_switch');
                },
              ),
              ItemMenu(
                label: 'Gerenciar Pontos',
                icon: Icon(Icons.lightbulb_outline),
                onTap: () {
                  Navigator.pushNamed(context, '/switch');
                },
              ),
              ItemMenu(
                label: 'Gerenciar Guarda',
                icon: Icon(Icons.shield_outlined),
                onTap: () {
                  // Navigator.pushNamed(context, '/guard');
                },
              ),
              ItemMenu(
                label: 'Perfil',
                icon: Icon(Icons.person_outline),
                onTap: () {
                  Navigator.pushNamed(context, '/perfil');
                },
              ),
              ItemMenu(
                label: 'Ajuda',
                icon: Icon(Icons.question_mark_outlined),
                onTap: () {
                  Navigator.pushNamed(context, '/help');
                },
              ),
              Container(
                color: Theme.of(context).colorScheme.onSecondary,
                child: ItemMenu(
                  label: 'Sair',
                  colorText: Theme.of(context).colorScheme.background,
                  icon: Icon(
                    Icons.logout,
                    color: Theme.of(context).colorScheme.background,
                  ),
                  onTap: () {
                    logout(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ItemMenu extends StatelessWidget {
  final String label;
  final Icon icon;
  final VoidCallback? onTap;
  final Color? tileColor;
  final Color? colorText;

  const ItemMenu({
    super.key,
    required this.label,
    required this.icon,
    this.tileColor,
    this.colorText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: tileColor,
      leading: icon,
      iconColor: Theme.of(context).colorScheme.primary,
      title: Text(
        label,
        style: TextStyle(
          color: colorText,
        ),
      ),
      onTap: onTap,
    );
  }
}
