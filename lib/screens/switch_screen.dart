// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

import '../widgets/header.dart';
import '../widgets/menu.dart';
import '../widgets/button_icon.dart';
import 'create_point_screen.dart';

class SwitchScreen extends StatefulWidget {
  const SwitchScreen({super.key});

  @override
  State<SwitchScreen> createState() => _SwitchScreenState();
}

class _SwitchScreenState extends State<SwitchScreen> {
  List<Point> points = [];

  @override
  void initState() {
    super.initState();
    _getPointsFromAPI();
  }

  void _getPointsFromAPI() {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        // Simulação de dados recebidos da API
        points = [
          Point(name: 'Ponto 1'),
          Point(name: 'Ponto 2'),
          Point(name: 'Ponto 3'),
        ];
      });
    });
  }

  void _refreshPoints() {
    _getPointsFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: 'Pontos'),
      endDrawer: MenuDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonIcon(
                  icon: Icon(Icons.add),
                  labelText: 'Criar Novo Preset',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreatePointScreen()),
                    );
                  },
                ),
                ButtonIcon(
                  icon: Icon(Icons.refresh),
                  labelText: 'Atualizar Pontos',
                  onPressed: () {
                    _refreshPoints();
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: points.length,
                itemBuilder: (context, index) {
                  return _buildPointCard(points[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPointCard(Point point) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      color: Theme.of(context).colorScheme.onSecondary,
      child: ListTile(
        title: Text(
          point.name,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.close,
            color: Theme.of(context).colorScheme.error,
          ),
          onPressed: () {
            _deletePoint(point);
          },
        ),
      ),
    );
  }

  void _deletePoint(Point point) {
    print('Excloi o ponto');
  }
}

class Point {
  final String name;

  Point({required this.name});
}
