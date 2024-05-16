import 'package:app_atalaia/utils/utils.dart';
import 'package:flutter/material.dart';
import '../screens/switch/switch_model.dart';

class SwitchCard extends StatefulWidget {
  final SwitchModel switchModel;

  const SwitchCard({Key? key, required this.switchModel}) : super(key: key);

  @override
  _SwitchCardState createState() => _SwitchCardState();
}

class _SwitchCardState extends State<SwitchCard> {
  bool isActive = false;

  @override
  void initState() {
    super.initState();
    isActive = widget.switchModel.isActive;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.onSecondary,
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              toCapitalizeWords(widget.switchModel.name),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isActive = !isActive;
                });
              },
              child: Icon(
                Icons.lightbulb,
                size: 40,
                color: isActive ? Colors.yellow : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
