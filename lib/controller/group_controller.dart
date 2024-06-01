import 'package:flutter/material.dart';
import '../model/group_model.dart';
import '../model/switch_model.dart';
import '../provider/group_provider.dart';
import '../utils/auth_provider.dart';

class GroupController extends ChangeNotifier {
  final GroupProvider _groupProvider = GroupProvider();
  final AuthProvider _authProvider = AuthProvider();

  Future<void> createGroup(
      BuildContext context, Map<String, dynamic> data) async {
    try {
      final response = await _groupProvider.createGroup(data);
      if (response['status'] == 'success') {
        return response['dados']['id'];
      } else {
        throw response['msg'];
      }
    } catch (error) {
      throw error.toString();
    }
  }

  Future<List<SwitchModel>> getSwitchesInGroup(
      BuildContext context, String groupId) async {
    try {
      final response = await _groupProvider.getSwitchesInGroup(groupId);
      if (response['status'] == 'success') {
        List<SwitchModel> switches = [];
        return switches;
      } else {
        throw response['msg'];
      }
    } catch (error) {
      throw error.toString();
    }
  }

  Future<List<GroupModel>> getGroups(BuildContext context) async {
    try {
      final userId = await _getUserId();
      final response = await _groupProvider.getGroups(userId);
      if (response['status'] == 'success') {
        List<GroupModel> groups = [];
        return groups;
      } else {
        throw response['msg'];
      }
    } catch (error) {
      throw error.toString();
    }
  }

  Future<bool> toggleGroup(Map<String, dynamic> data) async {
    try {
      final response = await _groupProvider.toggleGroup(data);
      if (response['status'] == 'success') {
        return true;
      } else {
        throw response['msg'];
      }
    } catch (error) {
      throw error.toString();
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
