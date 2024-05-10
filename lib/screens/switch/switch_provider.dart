import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../utils/config.dart';

class SwitchProvider extends ChangeNotifier {
  final Dio _dio = Dio();

  initDio() {
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 3);
  }

  Future<Map<String, dynamic>> createSwitch(
      String name, String watts, String macAddress, String userId) async {
    print(
        'PROVIDER - Name: $name Watts: $watts MAC Address: $macAddress User ID: $userId');
    try {
      final response = await _dio.post(
        '${Config.apiUrl}/switches/new',
        data: {
          'name': name,
          'watts': watts,
          'mac_address': macAddress,
          'user_id': userId,
        },
      );

      if (response.statusCode == 200) {
        return {'status': 'success', 'data': response.data};
      } else if (response.statusCode == 400) {
        throw Exception('Failed to create switch: ${response.data['msg']}');
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: ${response.data['msg']}');
      } else if (response.statusCode == 404) {
        throw Exception('Not found: ${response.data['msg']}');
      } else if (response.statusCode == 500) {
        throw Exception('Internal server error: ${response.data['msg']}');
      } else {
        throw Exception(
            'Unknown error occurred. Status code: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          throw Exception(
              'Failed to create switch: ${e.response!.data['msg']}');
        } else {
          throw Exception('Failed to connect to the server.');
        }
      } else {
        throw Exception('Unknown error occurred: $e');
      }
    }
  }
}
