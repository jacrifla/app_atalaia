import 'package:app_atalaia/utils/config.dart';
import 'package:dio/dio.dart';

class GuardManagementProvider {
  final Dio dio = Dio();

  GuardManagementProvider() {
    initDio();
  }

  void initDio() {
    dio.options.connectTimeout = const Duration(seconds: 5);
    dio.options.receiveTimeout = const Duration(seconds: 10);
    dio.options.baseUrl = Config.apiUrl;
  }

  Future<Response> getGuardInfo(Map<String, dynamic> data) async {
    try {
      final response = await dio.post(
        '/guard',
        data: data,
      );

      return response;
    } on DioException {
      throw ('Falha ao obter informações do guarda');
    }
  }

  Future<Response> defineSwitches(Map<String, dynamic> data) async {
    try {
      final response = await dio.post(
        '/guard/configswitch',
        data: data,
      );

      return response;
    } on DioException {
      throw ('Falha ao definir switches');
    }
  }

  Future<Response> toggleGuard(Map<String, dynamic> data) async {
    try {
      final response = await dio.post(
        '/guard/toggle',
        data: data,
      );

      return response;
    } on DioException {
      throw ('Falha ao alternar guarda');
    }
  }
}
