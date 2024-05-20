import 'package:flutter/material.dart';

import '../screens/confirmation_screen.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  void showConfirmationDialog(
      BuildContext context, String question, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationScreen(
          question: question,
          onConfirm: onConfirm,
        );
      },
    );
  }

  void logout(BuildContext context) {
    showConfirmationDialog(
      context,
      'Tem certeza que deseja sair?',
      () {
        Navigator.pushReplacementNamed(context, '/');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        // Espaçamento no topo do Drawer
        const SizedBox(height: 82),
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          // altura do menu
          height: screenHeight * 0.62,
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
              const SizedBox(height: 20),
              ItemMenu(
                label: 'Home',
                icon: const Icon(Icons.home_outlined),
                onTap: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
              ItemMenu(
                label: 'Gerenciar Grupos',
                icon: const Icon(Icons.tune),
                onTap: () {
                  Navigator.pushNamed(context, '/group_switch');
                },
              ),
              ItemMenu(
                label: 'Gerenciar Pontos',
                icon: const Icon(Icons.lightbulb_outline),
                onTap: () {
                  Navigator.pushNamed(context, '/switch');
                },
              ),
              ItemMenu(
                label: 'Gerenciar Guarda',
                icon: const Icon(Icons.shield_outlined),
                onTap: () {
                  Navigator.pushNamed(context, '/guard');
                },
              ),
              ItemMenu(
                label: 'Perfil',
                icon: const Icon(Icons.person_outline),
                onTap: () {
                  Navigator.pushNamed(context, '/perfil');
                },
              ),
              ItemMenu(
                label: 'Monitoramento',
                icon: const Icon(Icons.bar_chart_outlined),
                onTap: () {
                  Navigator.pushNamed(context, '/monitor');
                },
              ),
              ItemMenu(
                label: 'Ajuda',
                icon: const Icon(Icons.question_mark_outlined),
                onTap: () {
                  Navigator.pushNamed(context, '/help');
                },
              ),
              Container(
                color: Theme.of(context).colorScheme.onSecondary,
                child: ItemMenu(
                  label: 'Sair',
                  color: Theme.of(context).colorScheme.background,
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
  final Color? color;

  const ItemMenu({
    super.key,
    required this.label,
    required this.icon,
    this.tileColor,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon.icon,
        color: color ?? Theme.of(context).colorScheme.primary,
      ),
      title: Text(
        label,
        style: TextStyle(
          color: color ?? Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w400,
          fontSize: 18,
        ),
      ),
      onTap: onTap,
    );
  }
}
