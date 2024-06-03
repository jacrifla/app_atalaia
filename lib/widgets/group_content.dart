import 'package:flutter/material.dart';
import '../model/group_model.dart';
import 'group_card_actions.dart';
import 'group_card_toggle.dart';

class GroupContent extends StatelessWidget {
  final Future<List<GroupModel>> groupsFuture;
  final bool isDeleting;

  const GroupContent({
    required this.groupsFuture,
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
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final group = snapshot.data![index];
              if (isDeleting) {
                return GroupCardActions(
                  groupInfo: group,
                );
              } else {
                return GroupCardToggle(
                  groupInfo: group,
                );
              }
            },
          );
        }
      },
    );
  }
}
