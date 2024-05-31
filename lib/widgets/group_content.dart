import 'package:flutter/material.dart';

import 'group_card_delete.dart';
import '../model/group_model.dart';

class GroupContent extends StatelessWidget {
  final Future<List<GroupModel>> groupsFuture;

  const GroupContent({
    required this.groupsFuture,
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
              return GroupCard(groupInfo: snapshot.data![index]);
            },
          );
        }
      },
    );
  }
}
