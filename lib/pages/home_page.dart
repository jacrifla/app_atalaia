// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../widgets/button_icon.dart';
import '../widgets/icon_text_icon.dart';
import '../widgets/menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLightbulbTapped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(
            color: Color(0xFFF5F5F5),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Color(0xFFF5F5F5), size: 30),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ButtonIcon(
                    labelText: 'Presets',
                  ),
                  ButtonIcon(
                    labelText: 'Pontos',
                    backgroundColor: Color(0xfff5f5f5),
                    color: Color(0xFF202123),
                    borderSide: BorderSide(
                      color: Color(0xFF202123),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              IconTextIconRow(
                labelText: 'Sala de Estar',
                startIcon: Icon(
                  Icons.house,
                  color: Color(0xFFF5F5F5),
                ),
                defaultEndIcon: Icons.lightbulb,
                tappedEndIcon: Icons.lightbulb_outline,
                onTap: () {
                  setState(() {
                    isLightbulbTapped = !isLightbulbTapped;
                  });
                },
              ),
              IconTextIconRow(
                labelText: 'Perigo',
                startIcon: Icon(
                  Icons.shield_moon_outlined,
                  color: Color(0xFFD11111),
                ),
                defaultEndIcon: Icons.lightbulb,
                tappedEndIcon: Icons.lightbulb_outline,
                onTap: () {
                  setState(() {
                    isLightbulbTapped = !isLightbulbTapped;
                  });
                },
              ),
              IconTextIconRow(
                labelText: 'Hora de Dormir',
                startIcon: Icon(
                  Icons.mode_night_outlined,
                  color: Color(0xFFF5F5F5),
                ),
                defaultEndIcon: Icons.lightbulb,
                tappedEndIcon: Icons.lightbulb_outline,
                onTap: () {
                  setState(() {
                    isLightbulbTapped = !isLightbulbTapped;
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
