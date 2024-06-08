import 'package:dio/dio.dart';
import '../utils/config.dart';
import '../model/switch_model.dart';

class SwitchProvider {
  final Dio _dio = Dio();

  List<SwitchModel> switches = [];

  Future<Map<String, dynamic>> createSwitch(
      String name, String watts, String macAddress, String userId) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}/switches/new',
        data: {
          'name': name,
          'watts': watts,
          'mac_address': macAddress,
          'user_id': userId,
        },
      );

      return _handleResponse(response);
    } on DioException catch (error) {
      throw 'Erro ao conectar ao servidor: ${error.message}';
    }
  }

  Future<bool> updateSwitch(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}/switches/edit',
        data: data,
      );
      return response.statusCode == 200;
    } on DioException catch (error) {
      throw 'Erro ao conectar ao servidor: ${error.message}';
    }
  }

  Future<Map<String, dynamic>> deleteSwitch(String macAddress) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}/switches/delete',
        data: {'mac_address': macAddress},
      );

      return _handleResponse(response);
    } on DioException catch (error) {
      throw 'Erro ao conectar ao servidor: ${error.message}';
    }
  }

  Future<List<SwitchModel>> getSwitches(String userId) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}/switches',
        data: {'user_id': userId},
      );
      if (response.statusCode == 200) {
        List<SwitchModel> switches = [];
        for (var switchData in response.data['data']) {
          switches.add(SwitchModel.fromJson(switchData));
        }
        return switches;
      } else {
        return [];
      }
    } on DioException catch (error) {
      if (error.response?.statusCode == 404) {
        return [];
      } else if (error.response?.statusCode == 500) {
        throw 'Erro no servidor: ${error.response?.data['msg']}';
      }
      throw 'Erro ao conectar ao servidor: ${error.message}';
    }
  }

  Future<List<SwitchModel>> getSwitchesWithoutGroup(String userId) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}/switches/withoutgroup',
        data: {'user_id': userId},
      );
      if (response.statusCode == 200) {
        List<SwitchModel> switches = [];
        for (var switchData in response.data['data']) {
          switches.add(SwitchModel.fromJson(switchData));
        }
        return switches;
      } else {
        return [];
      }
    } on DioException catch (error) {
      if (error.response?.statusCode == 404) {
        return [];
      } else if (error.response?.statusCode == 500) {
        throw 'Erro no servidor: ${error.response?.data['msg']}';
      }
      throw 'Erro ao conectar ao servidor: ${error.message}';
    }
  }

  Future<Map<String, dynamic>> getSwitch(String macAddress) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}/switches/getone',
        data: {'mac_address': macAddress},
      );

      return response.data['dados'];
    } on DioException catch (error) {
      throw 'Erro ao conectar ao servidor: ${error.message}';
    }
  }

  Future<Map<String, dynamic>> toggleSwitch(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}/switches/toggle',
        data: data,
      );
      return _handleResponse(response);
    } on DioException catch (error) {
      throw 'Erro ao conectar ao servidor: ${error.message}';
    }
  }

  Map<String, dynamic> _handleResponse(Response response) {
    if (response.statusCode == 200) {
      return {'status': 'success', 'data': response.data};
    } else {
      throw 'Erro ao processar a requisição: ${response.data}';
    }
  }
}
