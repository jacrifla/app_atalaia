import 'package:flutter/material.dart';
import '../themes/theme.dart';
import '../utils/routes.dart';

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
                const ListTile(
                  title: Text(
                    'Menu',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      // Defina a cor de acordo com o seu tema
                      // color: appTheme.primaryColor,
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
                ),
                _buildMenuItem(
                  label: 'Gerenciar Grupos',
                  icon: const Icon(Icons.group_work),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.groupScreen);
                  },
                ),
                _buildMenuItem(
                  label: 'Gerenciar Pontos',
                  icon: const Icon(Icons.lightbulb),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.switchScreen);
                  },
                ),
                _buildMenuItem(
                  label: 'Gerenciar Guarda',
                  icon: const Icon(Icons.shield_sharp),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.guard);
                  },
                ),
                _buildMenuItem(
                  label: 'Perfil',
                  icon: const Icon(Icons.person),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.userProfile);
                  },
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
                ),
                Container(
                  color: appTheme.primaryColor,
                  child: _buildMenuItem(
                    label: 'Sair',
                    icon: Icon(
                      Icons.logout,
                      color: appTheme.colorScheme.background,
                    ),
                    onTap: () {
                      _showLogoutDialog(context);
                    },
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
  }) {
    return ListTile(
      leading: Icon(
        icon.icon,
        color: color ?? appTheme.primaryColor,
      ),
      title: Text(
        label,
        style: TextStyle(
          color: color ?? appTheme.primaryColor,
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tem certeza que deseja sair?'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, AppRoutes.login);
                  },
                  child: const Text('Sair'),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
