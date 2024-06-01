import 'package:app_atalaia/widgets/group_card_toggle.dart';
import 'package:flutter/material.dart';

import 'group_card_actions.dart';
import '../model/group_model.dart';

class GroupContent extends StatelessWidget {
  final Future<List<GroupModel>> groupsFuture;
  // Flag para determinar se estamos na tela de exclusão
  final bool isDeleting;

  const GroupContent({
    required this.groupsFuture,
    // Por padrão, não estamos na tela de exclusão
    this.isDeleting = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GroupModel>>(
      future: groupsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Nenhum grupo cadastrado'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              if (isDeleting) {
                // Se estamos na tela de exclusão, retorna o GroupCardDelete
                return GroupCardActions(groupInfo: snapshot.data![index]);
              } else {
                // Se não, retorna o GroupCardActions padrão
                return GroupCardToggle(groupInfo: snapshot.data![index]);
              }
            },
          );
        }
      },
    );
  }
}
