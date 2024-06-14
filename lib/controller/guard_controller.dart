import 'package:flutter/material.dart';
import '../provider/guard_provider.dart';
import '../utils/auth_provider.dart';

class GuardManagementController extends ChangeNotifier {
  final GuardManagementProvider provider;
  final String userId = AuthProvider().userId!;

  String? guardId;
  Map<String, dynamic>? guardInfo;

  GuardManagementController({required this.provider});

  Future<bool> getGuardInfo() async {
    try {
      final response = await provider.getGuardInfo({"user_id": userId});

      if (response != null && response.statusCode == 200) {
        guardInfo?.clear();
        guardInfo = response.data;
        guardId = guardInfo!['dados'][0]['guard_id'];

        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print('Error fetching guard info: $error');
      return false;
    }
  }

  Future<bool> defineSwitches(String macAddress, bool isActive) async {
    try {
      final response = await provider.defineSwitches({
        'user_id': userId,
        'mac_addresses': [macAddress],
        'is_active': isActive,
      });
      print(response);
      return response.statusCode == 200;
    } catch (error) {
      print('Error defining switches: $error');
      return false;
    }
  }

  Future<bool> toggleGuard() async {
    try {
      final response = await provider.toggleGuard({
        'user_id': userId,
        'guard_id': guardId,
      });

      return response.statusCode == 200;
    } catch (error) {
      print('Error toggling guard: $error');
      return false;
    }
  }
}
