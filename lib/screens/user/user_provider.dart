import 'package:app_atalaia/utils/config.dart';
import 'package:dio/dio.dart';

class UserProvider {
  final Dio _dio = Dio();

  Future<bool> updateUserInfo(
      String name, String userId, String email, String phone) async {
    try {
      final response = await _dio.put('${Config.apiUrl}user/update',
          data: {'name': name, 'uuid': userId, 'email': email, 'phone': phone});

      if (response.statusCode == 200) {
        return response.data['success'];
      } else {
        throw Exception(
            'Falha ao atualizar usuário. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Erro ao atualizar usuário: $error');
    }
  }

  Future<bool> softDelete(String userId) async {
    try {
      final response = await _dio.put(
        '${Config.apiUrl}user/delete',
        data: {'userId': userId},
      );

      if (response.statusCode == 200) {
        return response.data['success'];
      } else {
        throw 'Falha ao excluir usuário. Status code: ${response.statusCode}';
      }
    } catch (error) {
      throw 'Erro ao excluir usuário: $error';
    }
  }
}
