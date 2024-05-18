import 'package:flutter/material.dart';

import 'switch_model.dart';
import 'switch_provider.dart';

class SwitchController extends ChangeNotifier {
  final SwitchProvider _switchProvider = SwitchProvider();

  Future<bool> createSwitch(
      String name, String watts, String macAddress, String userId) async {
    try {
      final result =
          await _switchProvider.createSwitch(name, watts, macAddress, userId);

      return result['status'] == 'success';
    } catch (error) {
      return false;
    }
  }

  Future<List<SwitchModel>> getSwitches(String userId) async {
    try {
      return await _switchProvider.getSwitches(userId);
    } catch (error) {
      throw Exception('Erro ao obter switches: $error');
    }
  }

  Future<bool> updateSwitch(Map<String, dynamic> data) async {
    try {
      final result = await _switchProvider.updateSwitch(data);
      return result;
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

  Future<bool> toggleSwitch(
      String macAddress, bool isActive, String userId) async {
    try {
      final result =
          await _switchProvider.toggleSwitch(macAddress, isActive, userId);
      return result['status'] == 'success';
    } catch (error) {
      return false;
    }
  }
}
