import 'package:dio/dio.dart';

import '../utils/config.dart';

class GroupProvider {
  final Dio _dio = Dio();

  Future<Response?> getGroups(String userId) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}/groups',
        data: {'user_id': userId},
      );
      if (response.statusCode == 200) {
        return response;
      }
    } on DioException catch (error) {
      if (error.response?.statusCode == 400) {
        throw ('Erro interno');
      } else if (error.response?.statusCode == 500) {
        throw ('Erro do servidor');
      }
    }
    return null;
  }

  Future<Response?> getOneGroup(String groupId) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}/groups/getone',
        data: {'group_id': groupId},
      );
      if (response.statusCode == 200) {
        return response;
      }
    } on DioException catch (error) {
      if (error.response?.statusCode == 400) {
        throw ('Erro interno');
      } else if (error.response?.statusCode == 500) {
        throw ('Erro do servidor');
      }
    }
    return null;
  }

  Future<Response?> createGroup(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}/groups/new',
        data: data,
      );
      if (response.statusCode == 200) {
        return response;
      }
    } on DioException catch (error) {
      if (error.response?.statusCode == 400) {
        throw ('Erro interno');
      } else if (error.response?.statusCode == 500) {
        throw ('Erro do servidor');
      }
    }
    return null;
  }

  Future<Response?> updateGroup(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}/groups/edit',
        data: data,
      );
      if (response.statusCode == 200) {
        return response;
      }
    } on DioException catch (error) {
      if (error.response?.statusCode == 400) {
        throw ('Erro interno');
      } else if (error.response?.statusCode == 500) {
        throw ('Erro do servidor');
      }
    }
    return null;
  }

  Future<Response?> toggleGroup(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}/groups/toggle',
        data: data,
      );
      if (response.statusCode == 200) {
        return response;
      }
    } on DioException catch (error) {
      if (error.response?.statusCode == 400) {
        throw ('Nada foi mudado');
      } else if (error.response?.statusCode == 500) {
        throw ('Erro do servidor');
      }
    }
    return null;
  }

  Future<Response?> addSwitchToGroup(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}/groups/newswitch',
        data: data,
      );
      if (response.statusCode == 200) {
        return response;
      }
    } on DioException catch (error) {
      if (error.response?.statusCode == 400) {
        throw ('Erro interno');
      } else if (error.response?.statusCode == 500) {
        throw ('Erro do servidor');
      }
    }
    return null;
  }

  Future<Response?> getSwitchesInGroup(String groupId) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}/groups/switches',
        data: {'group_id': groupId},
      );
      if (response.statusCode == 200) {
        return response;
      }
    } on DioException catch (error) {
      if (error.response?.statusCode == 400) {
        throw ('Erro interno');
      } else if (error.response?.statusCode == 500) {
        throw ('Erro do servidor');
      }
    }
    return null;
  }

  Future<Response?> checkSwitchInGroup(String macAddress) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}/groups/checkswitch',
        data: {'mac_address': macAddress},
      );
      if (response.statusCode == 200) {
        return response;
      }
    } on DioException catch (error) {
      if (error.response?.statusCode == 400) {
        throw ('Erro interno');
      } else if (error.response?.statusCode == 500) {
        throw ('Erro do servidor');
      }
    }
    return null;
  }

  Future<Response?> removeSwitchFromGroup(String macAddress) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}/groups/removeswitch',
        data: {'mac_address': macAddress},
      );
      if (response.statusCode == 200) {
        return response;
      }
    } on DioException catch (error) {
      if (error.response?.statusCode == 400) {
        throw ('Erro interno');
      } else if (error.response?.statusCode == 500) {
        throw ('Erro do servidor');
      }
    }
    return null;
  }

  Future<Response?> deleteGroup(String groupId) async {
    try {
      final response = await _dio.post(
        '${Config.apiUrl}/groups/delete',
        data: {'group_id': groupId},
      );
      if (response.statusCode == 200) {
        return response;
      }
    } on DioException catch (error) {
      if (error.response?.statusCode == 400) {
        throw ('Erro interno');
      } else if (error.response?.statusCode == 500) {
        throw ('Erro do servidor');
      }
    }
    return null;
  }
}
