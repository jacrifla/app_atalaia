import 'package:flutter/material.dart';
import '../utils/routes.dart';
import '../view/confirmation_screen.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 82),
          Expanded(
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
                _buildMenuItem(
                  label: 'Home',
                  icon: const Icon(Icons.home),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.home);
                  },
                  context: context,
                ),
                _buildMenuItem(
                  label: 'Gerenciar Grupos',
                  icon: const Icon(Icons.group_work),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.groupScreen);
                  },
                  context: context,
                ),
                _buildMenuItem(
                  label: 'Gerenciar Pontos',
                  icon: const Icon(Icons.lightbulb),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.switchScreen);
                  },
                  context: context,
                ),
                _buildMenuItem(
                  label: 'Gerenciar Guarda',
                  icon: const Icon(Icons.shield_sharp),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.guard);
                  },
                  context: context,
                ),
                _buildMenuItem(
                  label: 'Perfil',
                  icon: const Icon(Icons.person),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.userProfile);
                  },
                  context: context,
                ),
                // _buildMenuItem(
                //   label: 'Monitoramento',
                //   icon: const Icon(Icons.bar_chart_rounded),
                //   onTap: () {
                //     Navigator.pushNamed(context, AppRoutes.monitor);
                //   },
                //   context: context,
                // ),
                _buildMenuItem(
                  label: 'Ajuda',
                  icon: const Icon(Icons.help_rounded),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.help);
                  },
                  context: context,
                ),
                Container(
                  color: Theme.of(context).colorScheme.primary,
                  child: _buildMenuItem(
                    label: 'Sair',
                    icon: Icon(
                      Icons.logout,
                      color: Theme.of(context).colorScheme.background,
                    ),
                    color: Theme.of(context).colorScheme.background,
                    onTap: () {
                      _logout(context);
                    },
                    context: context,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required String label,
    required Icon icon,
    VoidCallback? onTap,
    Color? color,
    required BuildContext context,
  }) {
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

  void _showConfirmationDialog(
    BuildContext context,
    String question,
    VoidCallback onConfirm,
  ) {
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

  void _logout(BuildContext context) {
    _showConfirmationDialog(
      context,
      'Tem certeza que deseja sair?',
      () {
        Navigator.pushReplacementNamed(context, '/');
      },
    );
  }
}
