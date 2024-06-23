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
      return response.data;
    } catch (error) {
      return {
        'status': 'error',
        'msg': 'Erro ao carregar os dados do usuário',
      };
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
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
      return response.data;
    } catch (error) {
      return {
        'status': 'error',
        'msg': 'Erro ao conectar ao servidor',
      };
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
      return response.data;
    } on DioException catch (e) {
      if (e.response != null && e.response?.statusCode == 409) {
        return {
          'status': 'error',
          'msg': e.response?.data['msg'] ?? 'Erro ao criar usuário'
        };
      }
    }
    return {'status': 'error', 'msg': 'Erro ao criar usuário'};
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
      return response.data;
    } catch (error) {
      return {'status': 'error', 'msg': 'Erro ao atualizar usuário'};
    }
  }

  Future<Map<String, dynamic>> deleteUser() async {
    try {
      initDio();
      final userId = getUserId();
      final response = await _dio.post(
        '${Config.apiUrl}/user/delete',
        data: {'user_id': userId},
      );
      return response.data;
    } catch (error) {
      return {'status': 'error', 'msg': 'Erro ao excluir usuário'};
    }
  }

  Future<Map<String, dynamic>> requestChangePassword(String email) async {
    try {
      initDio();
      final response = await _dio.post(
        '${Config.apiUrl}/password/reqChangePassword',
        data: {
          'email': email,
        },
      );
      return response.data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        return {
          'status': 'error',
          'msg': 'Erro ao enviar o email, verifique seu provedor de email'
        };
      }
      return {'status': 'error', 'msg': e};
    }
  }

  Future<Map<String, dynamic>> changePassword(
      String email, String token, String newPassword) async {
    try {
      initDio();
      final response = await _dio.post(
        '${Config.apiUrl}/password/changePassword',
        data: {
          'email': email,
          'token': token,
          'newPassword': newPassword,
        },
      );
      return response.data;
    } on DioException catch (e) {
      return {'status': 'error', 'msg': e};
    }
  }
}
