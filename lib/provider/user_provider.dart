import 'package:dio/dio.dart';
import '../utils/auth_provider.dart';
import '../utils/config.dart';

class UserProvider {
  final Dio _dio = Dio();
  final AuthProvider _authProvider;

  UserProvider(this._authProvider) {
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 3);
  }

  // Login Method
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

  // Signup Method
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

  // Update User Info Method
  Future<bool> updateUserInfo({
    required String userId,
    String? name,
    String? email,
    String? phone,
  }) async {
    try {
      // Cria um mapa dos dados a serem atualizados
      final Map<String, dynamic> data = {'uuid': userId};

      if (name != null) data['name'] = name;
      if (email != null) data['email'] = email;
      if (phone != null) data['phone'] = phone;

      // Verifica se há algum dado para atualizar
      if (data.length == 1) {
        // Apenas o userId está presente, não há nada para atualizar
        return false;
      }

      final response =
          await _dio.put('${Config.apiUrl}user/update', data: data);

      if (response.statusCode == 200) {
        return response.data['success'];
      } else {
        throw Exception(
            'Falha ao atualizar usuário. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw 'Erro ao atualizar usuário: $error';
    }
  }

  // Soft Delete User Method
  Future<bool> softDelete(String userId) async {
    try {
      final response = await _dio.put(
        '${Config.apiUrl}user/delete',
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
