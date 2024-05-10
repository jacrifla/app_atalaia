import 'package:app_atalaia/utils/config.dart';
import 'package:dio/dio.dart';

class SwitchController {
  final Dio _dio = Dio();

  Future<bool> createSwitch(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}/switch/create',
        data: data,
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }
}
