// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import '../screens/perfil_screen.dart';
import '../screens/switch_screen.dart';
import '../screens/group_screen.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

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
                icon: Icon(Icons.home),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
              ),
              ItemMenu(
                label: 'Grupos',
                icon: Icon(Icons.tune),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GroupScreen(),
                    ),
                  );
                },
              ),
              ItemMenu(
                label: 'Pontos',
                icon: Icon(Icons.lightbulb),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SwitchPage(),
                    ),
                  );
                },
              ),
              ItemMenu(
                label: 'Monitoramento',
                icon: Icon(Icons.bar_chart),
              ),
              ItemMenu(
                label: 'Perfil',
                icon: Icon(Icons.person),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PerfilPage(),
                    ),
                  );
                },
              ),
              ItemMenu(
                label: 'Ajuda',
                icon: Icon(Icons.question_mark_outlined),
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
                  onTap: () {},
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
