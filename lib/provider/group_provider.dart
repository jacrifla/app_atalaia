import 'package:app_atalaia/screens/group_switch/group_model.dart';
import 'package:flutter/material.dart';

class GroupProvider extends ChangeNotifier {
  final List<GroupModel> _groups = [];

  // Método para obter a lista de grupos
  List<GroupModel> get groups => _groups;

  // Adicione um grupo à lista
  void addGroup(GroupModel group) {
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
