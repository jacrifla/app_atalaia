// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

import '../pages/grupo_page.dart';
import '../pages/switch_page.dart';
import '../widgets/button_icon.dart';
import '../widgets/icon_text_icon.dart';
import '../widgets/menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLightbulbTapped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        title: Text(
          'Home',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ButtonIcon(
                    labelText: 'Grupos',
                    color: Theme.of(context).colorScheme.onPrimary,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GroupPage(),
                        ),
                      );
                    },
                  ),
                  ButtonIcon(
                    labelText: 'Pontos',
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    color: Theme.of(context).colorScheme.onSecondary,
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SwitchPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 50),
              IconTextIconRow(
                labelText: 'Sala de Estar',
                startIcon: Icon(
                  Icons.house,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                defaultEndIcon: Icons.lightbulb,
                tappedEndIcon: Icons.lightbulb_outline,
                onTap: () {
                  setState(() {
                    _isLightbulbTapped = !_isLightbulbTapped;
                  });
                },
              ),
              IconTextIconRow(
                labelText: 'Perigo',
                startIcon: Icon(
                  Icons.shield_moon_outlined,
                  color: Theme.of(context).colorScheme.error,
                ),
                defaultEndIcon: Icons.lightbulb,
                tappedEndIcon: Icons.lightbulb_outline,
                onTap: () {
                  setState(() {
                    _isLightbulbTapped = !_isLightbulbTapped;
                  });
                },
              ),
              IconTextIconRow(
                labelText: 'Hora de Dormir',
                startIcon: Icon(
                  Icons.mode_night_outlined,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                defaultEndIcon: Icons.lightbulb,
                tappedEndIcon: Icons.lightbulb_outline,
                onTap: () {
                  setState(() {
                    _isLightbulbTapped = !_isLightbulbTapped;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
