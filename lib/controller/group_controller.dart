import 'package:flutter/material.dart';

import '../provider/group_provider.dart';

class GroupController extends ChangeNotifier {
  final GroupProvider groupProvider;

  GroupController() : groupProvider = GroupProvider();

  // Método para alternar o status do grupo
  Future<bool> toggleGroup(String groupId, bool isActive, String userId) async {
    // Aqui você pode adicionar lógica para manipular a interação com o grupo
    // Por enquanto, vamos apenas chamar o método do provedor
    return await groupProvider.toggleGroup(groupId, isActive, userId);
  }
}
