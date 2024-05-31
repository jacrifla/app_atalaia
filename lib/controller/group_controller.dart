import 'package:flutter/material.dart';
import '../model/group_model.dart';
import '../model/switch_model.dart';
import '../provider/group_provider.dart';

class GroupController extends ChangeNotifier {
  final GroupProvider _groupProvider = GroupProvider();

  Future<void> createGroup(
      BuildContext context, Map<String, dynamic> data) async {
    try {
      Map<String, dynamic> response = await _groupProvider.createGroup(data);
      if (response['status'] == 'success') {
        // Exemplo: Navegar para a tela de detalhes do grupo
        Navigator.pushNamed(context, '/group_details',
            arguments: response['dados']['id']);
      } else {
        // Exemplo: Exibir uma mensagem de erro para o usuário
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Falha ao criar grupo: ${response['msg']}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      // Exemplo: Exibir uma mensagem de erro genérica para o usuário
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao criar grupo: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<List<SwitchModel>> getSwitchesInGroup(
      BuildContext context, String groupId) async {
    try {
      Map<String, dynamic> response =
          await _groupProvider.getSwitchesInGroup(groupId);
      if (response['status'] == 'success') {
        List<SwitchModel> switches =
            []; // Converta os dados de resposta para modelos de Switch
        // Lógica para converter dados de resposta em modelos de Switch
        return switches;
      } else {
        // Exemplo: Exibir uma mensagem de erro para o usuário
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Falha ao obter switches do grupo: ${response['msg']}'),
            backgroundColor: Colors.red,
          ),
        );
        return [];
      }
    } catch (error) {
      // Exemplo: Exibir uma mensagem de erro genérica para o usuário
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao obter switches do grupo: $error'),
          backgroundColor: Colors.red,
        ),
      );
      return [];
    }
  }

  Future<List<GroupModel>> getGroups(
      BuildContext context, String userId) async {
    try {
      Map<String, dynamic> response = await _groupProvider.getGroups(userId);
      if (response['status'] == 'success') {
        List<GroupModel> groups =
            []; // Converta os dados de resposta para modelos de Group
        // Lógica para converter dados de resposta em modelos de Group
        return groups;
      } else {
        // Exemplo: Exibir uma mensagem de erro para o usuário
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Falha ao obter grupos: ${response['msg']}'),
            backgroundColor: Colors.red,
          ),
        );
        return [];
      }
    } catch (error) {
      // Exemplo: Exibir uma mensagem de erro genérica para o usuário
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao obter grupos: $error'),
          backgroundColor: Colors.red,
        ),
      );
      return [];
    }
  }

  Future<void> checkSwitchInGroup(
      BuildContext context, String macAddress) async {
    try {
      Map<String, dynamic> response =
          await _groupProvider.checkSwitchInGroup(macAddress);
      if (response['status'] != 'success') {
        // Exemplo: Exibir uma mensagem de erro para o usuário
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Falha ao verificar o switch no grupo: ${response['msg']}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      // Exemplo: Exibir uma mensagem de erro genérica para o usuário
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao verificar o switch no grupo: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> addSwitchToGroup(
      BuildContext context, Map<String, dynamic> data) async {
    try {
      Map<String, dynamic> response =
          await _groupProvider.addSwitchToGroup(data);
      if (response['status'] != 'success') {
        // Exemplo: Exibir uma mensagem de erro para o usuário
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Falha ao adicionar switch ao grupo: ${response['msg']}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      // Exemplo: Exibir uma mensagem de erro genérica para o usuário
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao adicionar switch ao grupo: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<bool> toggleGroup(
      BuildContext context, Map<String, dynamic> data, String userId) async {
    try {
      Map<String, dynamic> response = await _groupProvider.toggleGroup(data);
      if (response['status'] == 'success') {
        return true;
      } else {
        // Exemplo: Exibir uma mensagem de erro para o usuário
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Falha ao alternar o grupo: ${response['msg']}'),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      }
    } catch (error) {
      // Exemplo: Exibir uma mensagem de erro genérica para o usuário
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao alternar o grupo: $error'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
  }

  Future<void> removeSwitchFromGroup(
      BuildContext context, String macAddress) async {
    try {
      Map<String, dynamic> response =
          await _groupProvider.removeSwitchFromGroup(macAddress);
      if (response['status'] != 'success') {
        // Exemplo: Exibir uma mensagem de erro para o usuário
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Falha ao remover switch do grupo: ${response['msg']}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      // Exemplo: Exibir uma mensagem de erro genérica para o usuário
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao remover switch do grupo: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> updateGroupInfo(
      BuildContext context, Map<String, dynamic> data) async {
    try {
      Map<String, dynamic> response =
          await _groupProvider.updateGroupInfo(data);
      if (response['status'] == 'success') {
        // Exemplo: Exibir uma mensagem de sucesso para o usuário
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Informações do grupo atualizadas com sucesso'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Exemplo: Exibir uma mensagem de erro para o usuário
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Falha ao atualizar informações do grupo: ${response['msg']}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      // Exemplo: Exibir uma mensagem de erro genérica para o usuário
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao atualizar informações do grupo: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> deleteGroup(BuildContext context, String groupId) async {
    try {
      Map<String, dynamic> response = await _groupProvider.deleteGroup(groupId);
      if (response['status'] == 'success') {
        // Exemplo: Exibir uma mensagem de sucesso para o usuário
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Grupo excluído com sucesso'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Exemplo: Exibir uma mensagem de erro para o usuário
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Falha ao excluir o grupo: ${response['msg']}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      // Exemplo: Exibir uma mensagem de erro genérica para o usuário
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao excluir o grupo: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
