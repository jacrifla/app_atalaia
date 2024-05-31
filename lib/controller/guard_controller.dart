import 'package:app_atalaia/controller/switch_controller.dart';

import '../provider/guard_provider.dart';

class GuardManagementController {
  final GuardManagementProvider _guardProvider = GuardManagementProvider();

  // Método para carregar os pontos associados à guarda
  Future<void> loadGuardPoints() async {
    await _guardProvider.loadGuardPoints();
  }

  // Método para adicionar um ponto associado à guarda
  Future<void> addGuardPoint(SwitchController point) async {
    await _guardProvider.addGuardPoint(point);
  }

  // Outros métodos conforme necessário
}
