import 'package:flutter/material.dart';
import '../screens/switch/switch_card.dart';
import '../screens/switch/switch_model.dart';

class SwitchContent extends StatelessWidget {
  final int selectedIndex;
  final Future<List<SwitchModel>> switchesFuture;

  const SwitchContent({
    required this.selectedIndex,
    required this.switchesFuture,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedIndex == 0) {
      return const Center(child: Text('Conteúdo dos Grupos'));
    } else if (selectedIndex == 1) {
      return FutureBuilder<List<SwitchModel>>(
        future: switchesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum switch cadastrado'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return SwitchCard(switchModel: snapshot.data![index]);
              },
            );
          }
        },
      );
    }
    return Container();
  }
}
