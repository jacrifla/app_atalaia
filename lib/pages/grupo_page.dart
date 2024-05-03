import 'package:app_atalaia/widgets/header.dart';
import 'package:flutter/material.dart';

import '../widgets/menu.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({super.key});

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: 'Grupo'),
      drawer: CustomDrawer(),
      body: Center(
        child: Text('Group Page'),
      ),
    );
  }
}
