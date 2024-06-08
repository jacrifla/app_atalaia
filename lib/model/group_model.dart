import 'package:flutter/material.dart';

class GroupModel {
  String? groupId;
  String? groupName;
  bool? isActive;
  bool? scheduleActive;
  String? scheduleStart;
  String? scheduleEnd;
  String? userId;
  List<String>? macAddresses;

  GroupModel({
    this.groupId,
    this.groupName,
    this.isActive,
    this.scheduleActive,
    this.scheduleStart,
    this.scheduleEnd,
    this.userId,
    this.macAddresses,
  });

  GroupModel.fromJson(Map<String, dynamic> json) {
    groupId = json['uuid'];
    groupName = json['name'];
    isActive = json.containsKey('is_active') ? json['is_active'] == 1 : false;
    scheduleActive = json.containsKey('schedule_active')
        ? json['schedule_active'] == 1
        : false;
    scheduleStart = json['schedule_start'];
    scheduleEnd = json['schedule_end'];
    userId = json['user_id'];
    macAddresses =
        json.containsKey('mac_address') && json['mac_address'] != null
            ? [json['mac_address']]
            : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = groupId;
    data['name'] = groupName;
    data['is_active'] = isActive;
    data['schedule_active'] = scheduleActive;
    data['schedule_start'] = scheduleStart;
    data['schedule_end'] = scheduleEnd;
    data['user_id'] = userId;
    data['mac_address'] = macAddresses;
    return data;
  }

  String formatTimeOfDayToString(TimeOfDay time) {
    return '${time.hour}:${time.minute}';
  }

  @override
  String toString() {
    return 'GroupModel(group_id: $groupId, groupName: $groupName, isActive: $isActive, scheduleActive: $scheduleActive, scheduleStart: $scheduleStart, scheduleEnd: $scheduleEnd, user_id: $userId, macAddresses: $macAddresses)';
  }

  factory GroupModel.fromJsonMap(Map<String, dynamic> json) {
    // Verifica se as chaves necessárias estão presentes no objeto json
    if (json.containsKey('uuid') &&
        json.containsKey('name') &&
        json.containsKey('is_active') &&
        json.containsKey('schedule_active') &&
        json.containsKey('schedule_start') &&
        json.containsKey('schedule_end') &&
        json.containsKey('user_id')) {
      return GroupModel(
        groupId: json['uuid'],
        groupName: json['name'],
        isActive: json['is_active'] == 1,
        scheduleActive: json['schedule_active'] == 1,
        scheduleStart: json['schedule_start'],
        scheduleEnd: json['schedule_end'],
        userId: json['user_id'],
        macAddresses: [json['mac_address'] ?? ''],
      );
    } else {
      // Se alguma chave estiver ausente, imprime uma mensagem de erro
      print('Erro: Algumas chaves estão ausentes no objeto json');
      // Retorna um novo GroupModel com valores nulos
      return GroupModel();
    }
  }
}
