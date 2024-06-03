import 'package:flutter/material.dart';
import '../model/group_model.dart';
import '../model/switch_model.dart';
import '../provider/group_provider.dart';
import '../utils/auth_provider.dart';

class GroupController extends ChangeNotifier {
  final GroupProvider _groupProvider = GroupProvider();
  final AuthProvider _authProvider = AuthProvider();
  String _userId = '';

  GroupController() {
    _userId = _authProvider.userId ?? '';
  }

  Future<void> createGroup({
    required String name,
    required bool isActive,
    required bool scheduleActive,
    required String scheduleStart,
    required String scheduleEnd,
    required String keepFor,
    int? activeHours,
  }) async {
    try {
      final Map<String, dynamic> data = {
        'name': name,
        'is_active': isActive,
        'schedule_active': scheduleActive,
        'schedule_start': scheduleStart,
        'schedule_end': scheduleEnd,
        'keep_for': keepFor,
        'user_id': await getUserId(),
      };

      if (activeHours != null) {
        data['active_hours'] = activeHours;
      }

      final response = await _groupProvider.createGroup(data);
      _checkResponse(response);
      return response['dados']['id'];
    } catch (error) {
      throw error.toString();
    }
  }

  Future<GroupModel> getOneGroup(String groupId) async {
    try {
      final response = await _groupProvider.getOneGroup(groupId);
      _checkResponse(response);
      return GroupModel.fromJson(response['dados']);
    } catch (error) {
      throw error.toString();
    }
  }

  Future<bool> checkSwitchInGroup(String macAddress) async {
    try {
      final response = await _groupProvider.checkSwitchInGroup(macAddress);
      _checkResponse(response);
      return true;
    } catch (error) {
      throw error.toString();
    }
  }

  Future<List<SwitchModel>> getSwitchesInGroup(String groupId) async {
    try {
      final response = await _groupProvider.getSwitchesInGroup(groupId);
      _checkResponse(response);
      return [];
    } catch (error) {
      throw error.toString();
    }
  }

  Future<List<GroupModel>> getGroups() async {
    try {
      final userId = await getUserId();
      final response = await _groupProvider.getGroups(userId);
      _checkResponse(response);
      List<GroupModel> groups = [];
      for (var groupData in response['dados']) {
        final groupDetails = await getOneGroup(groupData['uuid']);
        groups.add(groupDetails);
      }
      return groups;
    } catch (error) {
      throw error.toString();
    }
  }

  Future<bool> toggleGroup(Map<String, dynamic> data) async {
    try {
      final response = await _groupProvider.toggleGroup(data);
      _checkResponse(response);
      if (response['msg'] is bool) {
        return response['msg'];
      } else {
        return response['msg'] == 'active';
      }
    } catch (error) {
      throw error.toString();
    }
  }

  Future<void> addSwitchToGroup(Map<String, dynamic> data) async {
    try {
      final response = await _groupProvider.addSwitchToGroup(data);
      _checkResponse(response);
    } catch (error) {
      throw error.toString();
    }
  }

  Future<void> removeSwitchFromGroup(String macAddress) async {
    try {
      final response = await _groupProvider.removeSwitchFromGroup(macAddress);
      _checkResponse(response);
    } catch (error) {
      throw error.toString();
    }
  }

  Future<void> updateGroupInfo(Map<String, dynamic> data) async {
    try {
      final response = await _groupProvider.updateGroupInfo(data);
      _checkResponse(response);
    } catch (error) {
      throw error.toString();
    }
  }

  Future<void> deleteGroup(String groupId) async {
    try {
      final response = await _groupProvider.deleteGroup(groupId);
      _checkResponse(response);
    } catch (error) {
      throw error.toString();
    }
  }

  Future<List<GroupModel>> loadGroups() async {
    try {
      final userId = await getUserId();
      final response = await _groupProvider.getGroups(userId);
      _checkResponse(response);
      List<GroupModel> groups = [];
      for (var groupData in response['dados']) {
        final groupId = groupData['uuid'];
        final groupDetails = await getOneGroup(groupId);
        groups.add(groupDetails);
      }
      return groups;
    } catch (error) {
      throw error.toString();
    }
  }

  Future<String> getUserId() async {
    return _userId;
  }

  void _checkResponse(Map<String, dynamic> response) {
    if (response['status'] != 'success') {
      throw response['msg'];
    }
  }
}
