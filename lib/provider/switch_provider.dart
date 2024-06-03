// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import '../utils/config.dart';
import '../model/switch_model.dart';

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
        '${Config.apiUrl}/switches/new',
        data: {
          'name': name,
          'watts': watts,
          'mac_address': macAddress,
          'user_id': userId,
        },
      );

      if (response.statusCode == 200) {
        return _handleResponse(response);
      } else {
        throw 'Erro desconhecido. Status code: ${response.statusCode}';
      }
    } catch (error) {
      throw 'Erro ao conectar ao servidor: $error';
    }
  }

  Future<bool> updateSwitch(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}/switches/edit',
        data: data,
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw 'O servidor retornou uma resposta inesperada. Por favor, tente novamente mais tarde. Status code: ${response.statusCode}';
      }
    } catch (error) {
      throw 'Erro ao conectar ao servidor: $error';
    }
  }

  Future<Map<String, dynamic>> deleteSwitch(String macAddress) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}/switches/delete',
        data: {'mac_address': macAddress},
      );

      if (response.statusCode == 200) {
        return _handleResponse(response);
      } else {
        throw 'Erro desconhecido. Status code: ${response.statusCode}';
      }
    } catch (error) {
      throw 'Erro ao conectar ao servidor: $error';
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
        for (var switchData in response.data['dados']) {
          switches.add(SwitchModel.fromJson(switchData));
        }
        return switches;
      } else {
        throw 'Erro desconhecido. Status code: ${response.statusCode}';
      }
    } catch (error) {
      throw 'Erro ao conectar ao servidor: $error';
    }
  }

  Future<Map<String, dynamic>> getSwitch(String macAddress) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}/switches/getone',
        data: {'mac_address': macAddress},
      );

      if (response.statusCode == 200) {
        return {'status': 'success', 'data': response.data};
      } else {
        throw 'Erro desconhecido. Status code: ${response.statusCode}';
      }
    } catch (error) {
      throw 'Erro ao conectar ao servidor: $error';
    }
  }

  Future<Map<String, dynamic>> toggleSwitch(
      String macAddress, bool isActive, String userId) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}/switches/toggle',
        data: {
          'mac_address': macAddress,
          'user_id': userId,
          'is_active': isActive,
        },
      );

      if (response.statusCode == 200) {
        return _handleResponse(response);
      } else {
        throw 'Erro desconhecido. Status code: ${response.statusCode}';
      }
    } catch (error) {
      throw 'Erro ao conectar ao servidor: $error';
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
