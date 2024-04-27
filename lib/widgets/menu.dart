import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
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
            onTap: () {
              // Adicione aqui a lógica para o item 1
            },
          ),
          ListTile(
            title: Text('Pontos'),
            onTap: () {
              // Adicione aqui a lógica para o item 2
            },
          ),
          ListTile(
            title: Text('Monitoramento'),
            onTap: () {
              // Adicione aqui a lógica para o item 2
            },
          ),
          ListTile(
            title: Text('Perfil'),
            onTap: () {
              // Adicione aqui a lógica para o item 2
            },
          ),
          ListTile(
            title: Text('Ajuda'),
            onTap: () {
              // Adicione aqui a lógica para o item 2
            },
          ),
          ListTile(
            title: Text('Sair'),
            onTap: () {
              // Adicione aqui a lógica para o item 2
            },
          ),
          // Adicione mais ListTile conforme necessário
        ],
      ),
    );
  }
}
