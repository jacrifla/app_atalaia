// ignore_for_file: prefer_const_constructors

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
            title: Text('Presets'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Pontos'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Monitoramento'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Perfil'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Ajuda'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Sair'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
