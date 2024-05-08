import 'package:app_atalaia/screens/switch/switch_controller.dart';
import 'package:flutter/material.dart';

class GuardManagementProvider extends ChangeNotifier {
  List<SwitchController> _guardPoints = [];

  List<SwitchController> get guardPoints => _guardPoints;

  // Método para carregar os pontos associados à guarda
  Future<void> loadGuardPoints() async {
    // Lógica para carregar os pontos associados à guarda do banco de dados ou de uma API
    // Atualiza _guardPoints
    notifyListeners();
  }

  // Método para adicionar um ponto associado à guarda
  Future<void> addGuardPoint(SwitchController point) async {
    // Lógica para adicionar um ponto associado à guarda ao banco de dados ou a uma API
    // Atualiza _guardPoints
    notifyListeners();
  }

  // Outros métodos para atualizar, deletar pontos associados à guarda, etc.
}
