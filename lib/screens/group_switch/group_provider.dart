import 'package:flutter/material.dart';
import 'group_info.dart';

class GroupProvider extends ChangeNotifier {
  final List<GroupInfo> _groups = [];

  // Método para obter a lista de grupos
  List<GroupInfo> get groups => _groups;

  // Adicione um grupo à lista
  void addGroup(GroupInfo group) {
    _groups.add(group);
    notifyListeners(); // Notifica os ouvintes sobre a mudança
  }

  // Método para alternar o status do grupo
  Future<bool> toggleGroup(String groupId, bool isActive, String userId) async {
    // Lógica para alternar o status do grupo
    // Suponha que isso faça uma solicitação ao servidor para alternar o status do grupo
    // Por enquanto, vamos apenas simular um retorno de sucesso
    await Future.delayed(
        const Duration(seconds: 1)); // Simula uma operação assíncrona
    return true; // Retorno de sucesso
  }
}
