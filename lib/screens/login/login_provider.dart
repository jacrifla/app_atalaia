import 'package:dio/dio.dart';

import '../../utils/config.dart';

class LoginProvider {
  final Dio _dio = Dio();
  String? _userUuid;

  String? get userUuid => _userUuid;

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      Response response = await _dio.post(
        '${Config.apiUrl}login',
        data: {
          'email': email,
          'password_hash': password,
        },
      );

      if (response.statusCode == 200) {
        _userUuid = response.data['uuid'];
        print('UUID recebido após o login: $userUuid');
        return response.data;
      } else if (response.statusCode == 401) {
        throw Exception('Falha na Credencial');
      } else if (response.statusCode == 404) {
        throw Exception('Not found');
      } else {
        throw Exception(
            'Failed to connect to the server. Status code: ${response.statusCode}');
      }
    } catch (error) {
      if (error is DioError) {
        throw Exception('Failed to connect to the server.');
      } else {
        throw Exception('Failed to log in: $error');
      }
    }
  }
}
