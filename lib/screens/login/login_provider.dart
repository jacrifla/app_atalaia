import 'package:dio/dio.dart';

import '../../utils/auth_provider.dart';
import '../../utils/config.dart';

class LoginProvider {
  final Dio _dio = Dio();
  final AuthProvider _authProvider;

  LoginProvider(this._authProvider);

  initDio() {
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 3);
  }

  Future<void> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}login',
        data: {
          'email': email,
          'password_hash': password,
        },
      );

      if (response.statusCode == 200) {
        final userUuid = response.data['dados']['uuid'];
        _authProvider.setUserId(userUuid);
      } else if (response.statusCode == 404) {
        throw Exception('Usuário não encontrado');
      } else {
        throw Exception(
            'Failed to connect to the server. Status code: ${response.statusCode}');
      }
    } on DioException catch (error) {
      throw Exception('Failed to log in: $error');
    }
  }
}
