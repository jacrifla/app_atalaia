import 'package:flutter/material.dart';
import '../model/switch_model.dart';
import '../provider/switch_provider.dart';
import '../utils/auth_provider.dart';

class SwitchController extends ChangeNotifier {
  final SwitchProvider _switchProvider = SwitchProvider();
  final AuthProvider _authProvider = AuthProvider();

  Future<bool> createSwitch(
      String name, String watts, String macAddress) async {
    try {
      final userId = await _getUserId();
      final result =
          await _switchProvider.createSwitch(name, watts, macAddress, userId);

      return result['status'] == 'success';
    } catch (error) {
      return false;
    }
  }

  Future<List<SwitchModel>> getSwitches() async {
    try {
      final userId = await _getUserId();
      final switches = await _switchProvider.getSwitches(userId);
      // Notifica os ouvintes sobre a atualização dos switches
      notifyListeners();
      return switches;
    } catch (error) {
      throw 'Erro ao obter switches: $error';
    }
  }

  Future<bool> updateSwitch(Map<String, dynamic> data) async {
    try {
      return await _switchProvider.updateSwitch(data);
    } catch (error) {
      return false;
    }
  }

  Future<bool> deleteSwitch(String macAddress) async {
    try {
      final result = await _switchProvider.deleteSwitch(macAddress);
      return result['status'] == 'success';
    } catch (error) {
      return false;
    }
  }

  Future<bool> toggleSwitch(String macAddress, bool isActive) async {
    try {
      final userId = await _getUserId();
      final result =
          await _switchProvider.toggleSwitch(macAddress, isActive, userId);
      return result['status'] == 'success';
    } catch (error) {
      return false;
    }
  }

  Future<String> _getUserId() async {
    final userId = _authProvider.userId;
    if (userId == null) {
      throw 'Usuário não autenticado';
    }
    return userId;
  }
}
