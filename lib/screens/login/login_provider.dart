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
      }
    } catch (error) {
      if (error is DioError) {
        if (error.response?.statusCode == 401) {
          throw 'Credenciais inválidas. Por favor, verifique seu e-mail e senha.';
        } else if (error.response?.statusCode == 404) {
          throw 'Usuário não encontrado. Por favor, verifique seu e-mail.';
        } else {
          throw 'Erro ao conectar ao servidor. Por favor, tente novamente mais tarde.';
        }
      } else {
        throw 'Erro inesperado. Por favor, tente novamente mais tarde.';
      }
    }
  }
}
