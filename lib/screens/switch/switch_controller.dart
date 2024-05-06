import 'package:dio/dio.dart';

class SwitchController {
  static final Dio _dio =
      Dio(BaseOptions(baseUrl: 'http://192.168.1.25:80/app_atalaia/api2/'));

  static Future<bool> createSwitch({
    required String name,
    required String macAddress,
    required String watts,
  }) async {
    try {
      Response response = await _dio.post(
        '/switches/new',
        data: {
          'name': name,
          'mac_address': macAddress,
          'watts': watts,
        },
      );
      // Verifica se o código de status é 200 para determinar o sucesso da operação
      return response.statusCode == 200;
    } catch (e) {
      print('Error creating switch: $e');
      return false; // Retorna false em caso de erro
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
