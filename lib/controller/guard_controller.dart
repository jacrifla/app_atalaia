import 'package:flutter/material.dart';
import '../model/guard_model.dart';
import '../model/switch_model.dart';
import '../provider/guard_provider.dart';
import '../utils/auth_provider.dart';

class GuardController extends ChangeNotifier {
  final GuardProvider provider;
  final String userId = AuthProvider().userId!;

  GuardModel? guardInfo;

  GuardController({required this.provider});

  Future<String?> getGuardId() async {
    try {
      final response = await provider.getGuardInfo({"user_id": userId});

      if (response != null && response.statusCode == 200) {
        var data = response.data['dados'];
        if (data.isNotEmpty) {
          notifyListeners();
          return data[0]['guard_id'];
        }
      }
      return null;
    } catch (error) {
      print('Error fetching guard ID: $error');
      return null;
    }
  }

  Future<bool> getGuardInfo() async {
    try {
      final response = await provider.getGuardInfo({"user_id": userId});

      if (response != null && response.statusCode == 200) {
        var data = response.data['dados'];

        List<SwitchModel> switchList = data.map<SwitchModel>((item) {
          return SwitchModel(
            macAddress: item['mac_address'],
            name: item['switch_name'],
            guardActive: item['guard_active'] == '1',
            uuid: item['guard_id'],
          );
        }).toList();

        guardInfo = GuardModel(
          uuid: data[0]['guard_id'],
          switches: switchList,
        );

        print(guardInfo);

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

  Future<bool> defineSwitches(SwitchModel switchModel, bool isActive) async {
    try {
      final response = await provider.defineSwitches({
        'mac_address': switchModel.macAddress,
        'is_active': isActive,
      });
      if (response.statusCode == 200) {
        switchModel.guardActive = isActive;
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print('Error defining switches: $error');
      return false;
    }
  }

  Future<bool> toggleGuard() async {
    try {
      if (guardInfo == null) {
        print('Guard info is not available');
        return false;
      }

      final response = await provider.toggleGuard({
        'user_id': userId,
        'guard_id': guardInfo!.uuid,
      });

      if (response.statusCode == 200) {
        for (var switchModel in guardInfo!.switches!) {
          switchModel.guardActive = !switchModel.guardActive!;
        }
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print('Error toggling guard: $error');
      return false;
    }
  }
}
