import 'package:dio/dio.dart';

class LoginProvider {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      Response response = await _dio.post(
        'http://192.168.1.25:80/app_atalaia/api2/login',
        data: {
          'email': email,
          'password_hash': password,
        },
      );

      return response.data;
    } catch (error) {
      if (error is DioError) {
        throw Exception('Failed to connect to the server.');
      } else {
        throw Exception('Failed to log in: $error');
      }
    }
  }
}
