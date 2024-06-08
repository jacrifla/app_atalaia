import 'package:flutter/material.dart';

import '../utils/auth_provider.dart';
import '../model/group_model.dart';
import '../provider/group_provider.dart';

class GroupController extends ChangeNotifier {
  final GroupProvider provider;
  final String userId = AuthProvider().userId!;
  final GroupModel groupModel = GroupModel();

  GroupController({required this.provider});

  // Devolve a lista de groupIds que estao dentro do userId conectado
  Future<List<String>> getGroupsIds() async {
    try {
      Map<String, dynamic> response = await provider.getGroups(userId);
      if (response['status'] == 'success') {
        List<dynamic> data = response['dados'];
        List<String> groupIds =
            data.map((group) => group['uuid'] as String).toList();
        return groupIds;
      } else {
        throw ('Erro ao obter grupos');
      }
    } catch (error) {
      throw ('Erro ao obter grupos: $error');
    }
  }

  // Retorna as informacoes do grupo com base nas colunas da tabela
  Future<Map<String, dynamic>> getOneGroup(String groupId) async {
    try {
      Map<String, dynamic> response = await provider.getOneGroup(groupId);
      if (response['status'] == 'success') {
        return response['dados'];
      } else {
        throw ('Erro ao obter detalhes do grupo');
      }
    } catch (error) {
      throw ('Erro ao obter detalhes do grupo: $error');
    }
  }

  // Retorna o groupId do grupo criado
  Future<String> createGroup(
    String name,
    bool isActive,
    bool scheduleActive,
    String scheduleStart,
    String scheduleEnd,
  ) async {
    try {
      Map<String, dynamic> requestData = {
        "name": name,
        "is_active": isActive,
        "schedule_active": scheduleActive,
        "schedule_start": scheduleStart,
        "schedule_end": scheduleEnd,
        "user_id": userId
      };
      Map<String, dynamic> response = await provider.createGroup(requestData);
      if (response['status'] == 'success') {
        return response['dados']['uuid'];
      } else {
        throw ('Erro ao criar grupo');
      }
    } catch (error) {
      throw ('Erro ao criar grupo: $error');
    }
  }

  // Retorna true ou erro
  Future<bool> updateGroup(
    String groupId,
    String name,
    bool isActive,
    bool scheduleActive,
    String scheduleStart,
    String scheduleEnd,
  ) async {
    try {
      Map<String, dynamic> requestData = {
        "group_id": "41f886ea-245f-11ef-94a1-00090ffe0001",
        "name": name,
        "is_active": isActive,
        "schedule_active": scheduleActive,
        "schedule_start": scheduleStart,
        "schedule_end": scheduleEnd,
      };

      Map<String, dynamic> response = await provider.updateGroup(requestData);
      if (response['status'] == 'success') {
        return true;
      } else {
        throw ('Erro ao atualizar grupo');
      }
    } catch (error) {
      throw ('Erro ao atualizar grupo: $error');
    }
  }

  // Retorna true ou erro
  Future<bool> toggleGroup(String groupId, bool isActive) async {
    try {
      Map<String, dynamic> requestData = {
        'group_id': groupId,
        'is_active': isActive,
      };
      Map<String, dynamic> response = await provider.toggleGroup(requestData);
      if (response['status'] == 'success') {
        return true;
      } else {
        throw ('Erro ao alternar estado do grupo');
      }
    } catch (error) {
      throw ('Erro ao alternar estado do grupo: $error');
    }
  }

  // Retorna true ou erro
  Future<bool> addSwitchToGroup(String groupId, String macAddress) async {
    try {
      Map<String, dynamic> requestData = {
        'group_id': groupId,
        'mac_address': macAddress,
      };
      Map<String, dynamic> response =
          await provider.addSwitchToGroup(requestData);
      if (response['status'] == 'success') {
        return true;
      } else {
        throw ('Erro ao adicionar switch ao grupo');
      }
    } catch (error) {
      throw ('Erro ao adicionar switch ao grupo: $error');
    }
  }

  // retorna uma lista dos switches com todas as info dele ques estao dentro do grupo
  Future<List<Map<String, dynamic>>> getSwitchesInGroup(String groupId) async {
    try {
      Map<String, dynamic> response =
          await provider.getSwitchesInGroup(groupId);
      if (response['status'] == 'success') {
        List<dynamic> data = response['dados'];

        return data
            .map((switchData) => switchData as Map<String, dynamic>)
            .toList();
      } else {
        throw ('Erro ao obter switches do grupo');
      }
    } catch (error) {
      throw ('Erro ao obter switches do grupo: $error');
    }
  }

  // Retorna true ou erro
  Future<bool> checkSwitchInGroup(String macAddress) async {
    try {
      Map<String, dynamic> response =
          await provider.checkSwitchInGroup(macAddress);

      if (response['status'] == 'success') {
        return true;
      } else {
        throw ('Erro ao verificar switch no grupo');
      }
    } catch (error) {
      throw ('Erro ao verificar switch no grupo: $error');
    }
  }

  // Retorna true ou erro
  Future<bool> removeSwitchFromGroup(String macAddress) async {
    try {
      Map<String, dynamic> response =
          await provider.removeSwitchFromGroup(macAddress);
      if (response['status'] == 'success') {
        return true;
      } else {
        throw ('Erro ao remover switch do grupo');
      }
    } catch (error) {
      throw ('Erro ao remover switch do grupo: $error');
    }
  }

  // Retorna sempre sucesso
  Future<bool> deleteGroup(String groupId, [List<String>? macAddresses]) async {
    try {
      macAddresses ??= [];

      Map<String, dynamic> requestData = {
        'group_id': groupId,
        'mac_addresses': macAddresses,
      };
      Map<String, dynamic> response = await provider.deleteGroup(requestData);
      if (response['status'] == 'success') {
        return true;
      } else {
        throw ('Erro ao deletar grupo');
      }
    } catch (error) {
      throw ('Erro ao deletar grupo: $error');
    }
  }

  // Retorna todos os grupos associados ao usuário
  Future<List<GroupModel>> getAllGroups() async {
    try {
      final List<String> groupIds = await getGroupsIds();
      final List<GroupModel> groups = [];

      for (final groupId in groupIds) {
        final groupData = await getOneGroup(groupId);
        final group = GroupModel.fromJsonMap(groupData);
        groups.add(group);
      }

      return groups;
    } catch (error) {
      print('Erro ao obter todos os grupos: $error');
    }
    return [];
  }

  // Retorna a lista de endereços MAC dos switches do grupo
  Future<List<String>> getMacAddresses(String groupId) async {
    try {
      final List<Map<String, dynamic>> switchesInGroup =
          await getSwitchesInGroup(groupId);

      // Extrai os endereços MAC dos switches encontrados
      final List<String> macAddresses = switchesInGroup
          .map((switchData) => switchData['mac_address'] as String)
          .toList();
      return macAddresses;
    } catch (error) {
      return [];
    }
  }
}
