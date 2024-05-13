import 'switch_model.dart';
import 'switch_provider.dart';

class SwitchController {
  final SwitchProvider _switchProvider = SwitchProvider();

  Future<List<dynamic>> fetchSwitches(String userId) async {
    try {
      return await _switchProvider.fetchSwitches(userId);
    } catch (e) {
      print('CONTROLLER');
      throw Exception('erro no controller : $e');
    }
  }

  Future<bool> createSwitch(
      String name, String watts, String macAddress, String userId) async {
    try {
      final result =
          await _switchProvider.createSwitch(name, watts, macAddress, userId);

      return result['status'] == 'success';
    } catch (e) {
      return false;
    }
  }

  Future<List<SwitchModel>> getSwitches(String userId) async {
    try {
      return await _switchProvider.getSwitches(userId);
    } catch (e) {
      throw Exception('Erro ao obter switches: $e');
    }
  }

  Future<bool> updateSwitch(Map<String, dynamic> data) async {
    try {
      final result = await _switchProvider.updateSwitch(data);
      return result['status'] == 'success';
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteSwitch(String macAddress) async {
    try {
      final result = await _switchProvider.deleteSwitch(macAddress);
      return result['status'] == 'success';
    } catch (e) {
      return false;
    }
  }

  Future<bool> toggleSwitch(String macAddress) async {
    try {
      final result = await _switchProvider.toggleSwitch(macAddress);
      return result['status'] == 'success';
    } catch (e) {
      return false;
    }
  }
}
