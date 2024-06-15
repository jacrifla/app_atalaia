import 'package:dio/dio.dart';
import '../utils/auth_provider.dart';
import '../utils/config.dart';

class UserProvider {
  final Dio _dio = Dio();
  final AuthProvider _authProvider = AuthProvider();

  void initDio() {
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 3);
  }

  String getUserId() {
    return _authProvider.userId!;
  }

  Future<Map<String, dynamic>> getUser(String userId) async {
    try {
      initDio();
      final response =
          await _dio.post('${Config.apiUrl}/user', data: {'user_id': userId});
      if (response.data['status'] == 'success') {
        return response.data['dados'];
      }
    } on DioException {
      rethrow;
    }
    return {};
  }

  Future<void> login(String email, String password) async {
    try {
      initDio();

      final response = await _dio.post(
        '${Config.apiUrl}/login',
        data: {
          'email': email,
          'password_hash': password,
        },
      );

      if (response.statusCode == 200) {
        final userId = response.data['dados']['uuid'];
        _authProvider.setUserId(userId);
      }
    } catch (error) {
      if (error is DioException) {
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

  Future<Map<String, dynamic>> createUser(
      String name, String email, String phone, String password) async {
    try {
      initDio();

      final response = await _dio.post(
        '${Config.apiUrl}/register',
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
      if (e is DioException) {
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

  Future<Map<String, dynamic>> updateUser(
      String name, String email, String phone) async {
    try {
      initDio();

      final userId = getUserId();
      final response = await _dio.post(
        '${Config.apiUrl}/user/update',
        data: {
          'name': name,
          'user_id': userId,
          'email': email,
          'phone': phone,
        },
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw 'Falha ao atualizar usuário. Status code: ${response.statusCode}';
      }
    } on DioException catch (error) {
      if (error.response?.statusCode == 401) {
        throw 'Credenciais inválidas. Por favor, verifique seu e-mail e senha.';
      } else if (error.response?.statusCode == 404) {
        throw 'Usuário não encontrado. Por favor, verifique seu e-mail.';
      } else {
        throw 'Erro ao conectar ao servidor. Por favor, tente novamente mais tarde.';
      }
    }
  }

  Future<bool> deleteUser() async {
    try {
      initDio();
      final userId = getUserId();

      final response = await _dio.post(
        '${Config.apiUrl}/user/delete',
        data: {'user_id': userId},
      );

      if (response.statusCode == 200) {
        return response.data['dados'];
      } else {
        throw 'Falha ao excluir usuário. Status code: ${response.statusCode}';
      }
    } catch (error) {
      throw 'Erro ao excluir usuário: $error';
    }
  }
}
