// ignore_for_file: prefer_const_constructors

import 'package:app_atalaia/pages/home_page.dart';
import 'package:app_atalaia/pages/perfil_page.dart';
import 'package:app_atalaia/pages/switch_page.dart';
import 'package:flutter/material.dart';

import '../pages/grupo_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 82), // Espaçamento no topo do Drawer
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
                      builder: (context) => HomePage(),
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
                      builder: (context) => GroupPage(),
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
              // ItemMenu(
              //   label: 'Monitoramento',
              //   icon: Icon(Icons.bar_chart),
              //   height: itemHeight,
              // ),
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
              // ItemMenu(
              //   label: 'Ajuda',
              //   icon: Icon(Icons.question_mark_outlined),
              //   height: itemHeight,
              // ),
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
