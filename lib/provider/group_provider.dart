import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../utils/config.dart';

class GroupProvider extends ChangeNotifier {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> _postData(String url, dynamic data) async {
    try {
      Response response = await _dio.post('$url', data: data);
      return response.data;
    } catch (error) {
      throw Exception('Failed to perform POST request: $error');
    }
  }

  Future<Map<String, dynamic>> createGroup(Map<String, dynamic> data) async {
    return _postData('${Config.apiUrl}/groups/new', jsonEncode(data));
  }

  Future<Map<String, dynamic>> getOneGroup(String groupId) async {
    return _postData(
        '${Config.apiUrl}/groups/getone', jsonEncode({'group_id': groupId}));
  }

  Future<Map<String, dynamic>> getSwitchesInGroup(String groupId) async {
    return _postData('${Config.apiUrl}/groups/switches', {'group_id': groupId});
  }

  Future<Map<String, dynamic>> getGroups(String userId) async {
    return _postData('${Config.apiUrl}/groups', {'user_id': userId});
  }

  Future<Map<String, dynamic>> checkSwitchInGroup(String macAddress) async {
    return _postData(
        '${Config.apiUrl}/groups/checkswitch', {'mac_address': macAddress});
  }

  Future<Map<String, dynamic>> addSwitchToGroup(
      Map<String, dynamic> data) async {
    return _postData('${Config.apiUrl}/groups/newswitch', jsonEncode(data));
  }

  Future<Map<String, dynamic>> toggleGroup(Map<String, dynamic> data) async {
    try {
      Response response = await _dio.post('${Config.apiUrl}/groups/toggle',
          data: jsonEncode(data));
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
    return _postData(
        '${Config.apiUrl}/groups/removeswitch', {'mac_address': macAddress});
  }

  Future<Map<String, dynamic>> updateGroupInfo(
      Map<String, dynamic> data) async {
    return _postData('${Config.apiUrl}/groups/edit', jsonEncode(data));
  }

  Future<Map<String, dynamic>> deleteGroup(String groupId) async {
    return _postData('${Config.apiUrl}/groups/delete', {'group_id': groupId});
  }
}
