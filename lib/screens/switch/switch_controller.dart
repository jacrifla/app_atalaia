import 'package:dio/dio.dart';

import '../../utils/config.dart';

class SwitchController {
  static final Dio _dio =
      Dio(BaseOptions(baseUrl: 'http://192.168.1.25:80/app_atalaia/api2/'));

  Future<bool> createSwitch({
    required String macAddress,
    required String name,
    required int watts,
    required String userId,
  }) async {
    try {
      final Dio dio = Dio();
      final response = await dio.post(
        '${Config.apiUrl}switches/create',
        data: {
          'mac_address': macAddress,
          'name': name,
          'watts': watts,
          'user_id': userId,
        },
      );

      if (response.statusCode == 200) {
        print('Switch created successfully');
        return true;
      } else {
        print('Failed to create switch. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error creating switch: $e');
      return false;
    }
  }

  static Future<void> updateSwitch(Map<String, dynamic> data) async {
    try {
      Response response = await _dio.put(
        '/switches/edit',
        data: data,
      );
      print(response.data);
    } catch (e) {
      print('Error updating switch: $e');
    }
  }

  static Future<void> deleteSwitch(String macAddress) async {
    try {
      Response response = await _dio.put(
        '/switches/delete',
        data: {'mac_address': macAddress},
      );
      print(response.data);
    } catch (e) {
      print('Error deleting switch: $e');
    }
  }

  static Future<void> toggleSwitch(Map<String, dynamic> data) async {
    try {
      Response response = await _dio.put(
        '/switches/toggle',
        data: data,
      );
      print(response.data);
    } catch (e) {
      print('Error toggling switch: $e');
    }
  }

  static Future<List<dynamic>> getSwitches(String userId) async {
    try {
      Response response = await _dio.get(
        '/switches?user_id=$userId',
      );
      return response.data;
    } catch (e) {
      print('Error getting switches: $e');
      return [];
    }
  }

  static Future<Map<String, dynamic>?> getSwitch(String macAddress) async {
    try {
      Response response = await _dio.get(
        '/switches/getone?mac_address=$macAddress',
      );
      return response.data;
    } catch (e) {
      print('Error getting switch: $e');
      return null;
    }
  }
}
