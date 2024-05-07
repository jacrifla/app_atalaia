import 'package:dio/dio.dart';

class SignupProvider {
  final Dio dio = Dio();

  initDio() {
    dio.options.connectTimeout = const Duration(seconds: 5);
    dio.options.receiveTimeout = const Duration(seconds: 3);
  }

  Future<Map<String, dynamic>> createUser(
      String name, String email, String phone, String password) async {
    try {
      final response = await dio.post(
        'http://192.168.1.25:80/app_atalaia/api2/register',
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
        return {'status': 'error', 'message': response.data['msg']};
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          return {'status': 'error', 'message': e.response!.data['msg']};
        } else {
          return {'status': 'error', 'message': 'Falha de conexão.'};
        }
      } else {
        return {'status': 'error', 'message': 'Erro desconhecido.'};
      }
    }
  }
}
