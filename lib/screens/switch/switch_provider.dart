import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import '../../utils/config.dart';
import 'switch_model.dart';

class SwitchProvider extends ChangeNotifier {
  final Dio _dio = Dio();

  List<SwitchModel> _switches = [];
  List<SwitchModel> get switches => _switches;

  set switches(List<SwitchModel> value) {
    _switches = value;
    notifyListeners();
  }

  Future<Map<String, dynamic>> createSwitch(
      String name, String watts, String macAddress, String userId) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}switches/new',
        data: {
          'name': name,
          'watts': watts,
          'mac_address': macAddress,
          'user_id': userId,
        },
      );

      return _handleResponse(response);
    } catch (error) {
      return _handleError(error);
    }
  }

  Future<List<SwitchModel>> getSwitches(String userId) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}switches',
        data: {'user_id': userId},
      );

      if (response.statusCode == 200) {
        List<SwitchModel> switches = [];
        for (var switchData in response.data['dados']) {
          switches.add(SwitchModel.fromJson(switchData));
        }
        return switches;
      } else if (response.statusCode == 400) {
        throw Exception('Erro interno: ${response.data['msg']}');
      } else if (response.statusCode == 500) {
        throw Exception('Erro no servidor: ${response.data['msg']}');
      } else {
        throw Exception(
            'Erro desconhecido. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Erro ao conectar ao servidor: $error');
    }
  }

  Future<Map<String, dynamic>> getSwitch(String macAddress) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}switches/getone',
        data: {'mac_address': macAddress},
      );

      if (response.statusCode == 200) {
        return {'status': 'success', 'data': response.data};
      } else if (response.statusCode == 400) {
        throw Exception('Erro interno: ${response.data['msg']}');
      } else if (response.statusCode == 500) {
        throw Exception('Erro no servidor: ${response.data['msg']}');
      } else {
        throw Exception(
            'Erro desconhecido. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Erro ao conectar ao servidor: $error');
    }
  }

  Future<Map<String, dynamic>> updateSwitch(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}switches/update',
        data: data,
      );

      return _handleResponse(response);
    } catch (error) {
      return _handleError(error);
    }
  }

  Future<Map<String, dynamic>> deleteSwitch(String macAddress) async {
    try {
      final response = await _dio.put(
        '${Config.apiUrl}switches/delete',
        data: {'mac_address': macAddress},
      );

      if (response.statusCode == 200) {
        return _handleResponse(response);
      } else if (response.statusCode == 400) {
        throw Exception('Erro interno: ${response.data['msg']}');
      } else if (response.statusCode == 500) {
        throw Exception('Erro no servidor: ${response.data['msg']}');
      } else {
        throw Exception(
            'Erro desconhecido. Status code: ${response.statusCode}');
      }
    } catch (error) {
      return _handleError(error);
    }
  }

  Future<Map<String, dynamic>> toggleSwitch(String macAddress) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}switches/toggle',
        data: {'mac_address': macAddress},
      );

      return _handleResponse(response);
    } catch (error) {
      return _handleError(error);
    }
  }

  Map<String, dynamic> _handleResponse(Response response) {
    if (response.statusCode == 200) {
      return {'status': 'success', 'data': response.data};
    } else {
      throw Exception('Erro ao processar a requisição: ${response.data}');
    }
  }

  Map<String, dynamic> _handleError(error) {
    throw Exception('Erro ao processar a requisição: $error');
  }
}
