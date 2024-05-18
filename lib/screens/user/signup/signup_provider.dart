import 'package:dio/dio.dart';

import '../../../utils/config.dart';

class SignupProvider {
  final Dio _dio = Dio();

  initDio() {
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 3);
  }

  Future<Map<String, dynamic>> createUser(
      String name, String email, String phone, String password) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}register',
        data: {
          'name': name,
          'email': email,
          'phone': phone,
          'password_hash': password,
        },
      );

      if (response.statusCode == 201) {
        return {'status': 'success', 'data': response.data};
      } else {
        throw 'Failed to create user: ${response.data['msg']}';
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          throw 'Failed to create user: ${e.response!.data['msg']}';
        } else {
          throw 'Failed to connect to the server.';
        }
      } else {
        throw 'Unknown error occurred.';
      }
    }
  }
}
