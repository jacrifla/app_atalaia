import 'package:flutter/material.dart';
import 'switch_card_toggle.dart';
import 'switch_card_delete.dart';
import '../model/switch_model.dart';

class SwitchContent extends StatelessWidget {
  final int selectedIndex;
  final Future<List<SwitchModel>> switchesFuture;
  final bool isDeleting;

  const SwitchContent({
    required this.selectedIndex,
    required this.switchesFuture,
    this.isDeleting = false,
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
                // Verificar se esta na tela de exclusão
                if (isDeleting) {
                  // Se sim, retornar o SwitchCardDelete
                  return SwitchCardDelete(switchModel: snapshot.data![index]);
                } else {
                  // Se não, retorna o SwitchCard padrão
                  return SwitchCard(switchModel: snapshot.data![index]);
                }
              },
            );
          }
        },
      );
    }
    return Container();
  }
}
