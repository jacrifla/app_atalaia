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
      } else {
        throw 'Erro desconhecido. Status code: ${response.statusCode}';
      }
    } catch (error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          throw 'Erro interno: $error';
        } else if (error.response?.statusCode == 500) {
          throw 'Erro no servidor: $error';
        } else {
          throw 'Erro ao conectar ao servidor. Por favor, tente novamente mais tarde.';
        }
      } else {
        throw 'Erro inesperado. Por favor, tente novamente mais tarde.';
      }
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
      } else {
        throw 'Erro desconhecido. Status code: ${response.statusCode}';
      }
    } catch (error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          throw 'Erro interno: ${error.response?.data['msg']}';
        } else if (error.response?.statusCode == 500) {
          throw 'Erro no servidor: ${error.response?.data['msg']}';
        } else {
          throw 'Erro ao conectar ao servidor. Por favor, tente novamente mais tarde. Status code: ${error.response?.statusCode}';
        }
      } else {
        throw 'Erro ao conectar ao servidor: $error';
      }
    }
  }

  Future<bool> updateSwitch(Map<String, dynamic> data) async {
    try {
      final response = await _dio.put(
        '${Config.apiUrl}switches/edit',
        data: data,
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw 'O servidor retornou uma resposta inesperada. Por favor, tente novamente mais tarde. Status code: ${response.statusCode}';
      }
    } catch (error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          throw 'Não foi possível processar a solicitação.';
        } else if (error.response?.statusCode == 500) {
          throw 'Houve um problema ao processar a solicitação. Por favor, tente novamente mais tarde.';
        } else {
          print('Erro ao atualizar o switch: $error');
        }
      }
      return false;
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
      } else {
        throw 'Erro desconhecido. Status code: ${response.statusCode}';
      }
    } catch (error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          throw 'Erro interno: ${error.response?.data['msg']}';
        } else if (error.response?.statusCode == 500) {
          throw 'Erro no servidor: ${error.response?.data['msg']}';
        } else {
          throw 'Erro ao conectar ao servidor. Por favor, tente novamente mais tarde. Status code: ${error.response?.statusCode}';
        }
      }
      return _handleError(error);
    }
  }

  Future<Map<String, dynamic>> toggleSwitch(String macAddress) async {
    try {
      final response = await _dio.put(
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
      throw 'Erro ao processar a requisição: ${response.data}';
    }
  }

  Map<String, dynamic> _handleError(error) {
    throw 'Erro ao processar a requisição: $error';
  }
}
