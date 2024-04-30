// ignore_for_file: prefer_const_constructors

import 'package:app_atalaia/pages/perfil_page.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.tune),
            title: Text('Presets'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.lightbulb),
            title: Text('Pontos'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.bar_chart),
            title: Text('Monitoramento'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Perfil'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PerfilPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.question_mark_outlined),
            title: Text('Ajuda'),
            onTap: () {},
          ),
          ListTile(
            tileColor: Theme.of(context).colorScheme.onSecondary,
            leading: Icon(
              Icons.logout,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            title: Text(
              'Sair',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
