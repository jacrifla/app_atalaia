import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../utils/config.dart';

class GroupProvider extends ChangeNotifier {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> createGroup(Map<String, dynamic> data) async {
    try {
      Response response = await _dio.post(
        '${Config.apiUrl}/groups/new',
        data: jsonEncode(data),
      );
      return response.data;
    } catch (error) {
      throw Exception('Failed to create group: $error');
    }
  }

  Future<Map<String, dynamic>> getOneGroup(String groupId) async {
    try {
      Response response = await _dio.post(
        '${Config.apiUrl}/groups/getone',
        data: jsonEncode({'group_id': groupId}),
      );
      return response.data;
    } catch (error) {
      throw Exception('Failed to get group: $error');
    }
  }

  Future<Map<String, dynamic>> getSwitchesInGroup(String groupId) async {
    try {
      Response response = await _dio.post(
        '${Config.apiUrl}/groups/switches',
        data: {'group_id': groupId},
      );
      return response.data;
    } catch (error) {
      throw Exception('Failed to get switches in group: $error');
    }
  }

  Future<Map<String, dynamic>> getGroups(String userId) async {
    try {
      Response response = await _dio.post(
        '${Config.apiUrl}/groups',
        data: {'user_id': userId},
      );
      return response.data;
    } catch (error) {
      throw Exception('Failed to get groups: $error');
    }
  }

  Future<Map<String, dynamic>> checkSwitchInGroup(String macAddress) async {
    try {
      Response response = await _dio.post(
        '${Config.apiUrl}/groups/checkswitch',
        data: {'mac_address': macAddress},
      );
      return response.data;
    } catch (error) {
      throw Exception('Failed to check switch in group: $error');
    }
  }

  Future<Map<String, dynamic>> addSwitchToGroup(
      Map<String, dynamic> data) async {
    try {
      Response response = await _dio.post(
        '${Config.apiUrl}/groups/newswitch',
        data: jsonEncode(data),
      );
      return response.data;
    } catch (error) {
      throw Exception('Failed to add switch to group: $error');
    }
  }

  Future<Map<String, dynamic>> toggleGroup(Map<String, dynamic> data) async {
    try {
      Response response = await _dio.post(
        '${Config.apiUrl}/groups/toggle',
        data: jsonEncode(data),
      );
      if (response.data != null) {
        return response.data;
      } else {
        throw Exception('Response data is null');
      }
    } catch (error) {
      throw Exception('Failed to toggle group: $error');
    }
  }

  Future<Map<String, dynamic>> removeSwitchFromGroup(String macAddress) async {
    try {
      Response response = await _dio.post(
        '${Config.apiUrl}/groups/removeswitch',
        data: {'mac_address': macAddress},
      );
      return response.data;
    } catch (error) {
      throw Exception('Failed to remove switch from group: $error');
    }
  }

  Future<Map<String, dynamic>> updateGroupInfo(
      Map<String, dynamic> data) async {
    try {
      Response response = await _dio.post(
        '${Config.apiUrl}/groups/edit',
        data: jsonEncode(data),
      );
      return response.data;
    } catch (error) {
      throw Exception('Failed to update group info: $error');
    }
  }

  Future<Map<String, dynamic>> deleteGroup(String groupId) async {
    try {
      Response response = await _dio.post(
        '${Config.apiUrl}/groups/delete',
        data: {'group_id': groupId},
      );
      return response.data;
    } catch (error) {
      throw Exception('Failed to delete group: $error');
    }
  }
}
