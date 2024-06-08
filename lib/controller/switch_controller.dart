import 'package:flutter/material.dart';
import '../model/switch_model.dart';
import '../provider/switch_provider.dart';
import '../utils/auth_provider.dart';

class SwitchController extends ChangeNotifier {
  final SwitchProvider _switchProvider;
  final String userId = AuthProvider().userId!;

  SwitchController(this._switchProvider);

  Future<bool> createSwitch(
      String name, String watts, String macAddress) async {
    try {
      final result = await _switchProvider.createSwitch(
        name,
        watts,
        macAddress,
        userId,
      );
      notifyListeners();

      return result['status'] == 'success';
    } catch (error) {
      return false;
    }
  }

  Future<List<SwitchModel>> getSwitches() async {
    try {
      final switches = await _switchProvider.getSwitches(userId);
      notifyListeners();
      return switches;
    } catch (error) {
      return [];
    }
  }

  Future<bool> updateSwitch({
    required String name,
    required String watts,
    required String macAddress,
  }) async {
    try {
      final Map<String, dynamic> data = {
        'name': name,
        'watts': watts,
        'mac_address': macAddress,
      };

      final success = await _switchProvider.updateSwitch(data);
      if (success) {
        notifyListeners();
      }
      return success;
    } catch (error) {
      return false;
    }
  }

  Future<bool> deleteSwitch({required String macAddress}) async {
    try {
      final result = await _switchProvider.deleteSwitch(macAddress);
      notifyListeners();
      return result['status'] == 'success';
    } catch (error) {
      return false;
    }
  }

  Future<bool> toggleSwitch(
      {required String macAddress, required bool isActive}) async {
    try {
      final Map<String, dynamic> data = {
        'mac_address': macAddress,
        'user_id': userId,
        'is_active': isActive,
      };
      final success = await _switchProvider.toggleSwitch(data);
      notifyListeners();
      return success['status'] == 'success';
    } catch (error) {
      return false;
    }
  }
}
