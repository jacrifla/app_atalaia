import 'package:flutter/material.dart';

class GroupModel {
  String? groupId;
  String? groupName;
  bool? isActive;
  bool? scheduleActive;
  String? scheduleStart;
  String? scheduleEnd;
  String? userId;
  String? macAddress;

  GroupModel({
    this.groupId,
    this.groupName,
    this.isActive,
    this.scheduleActive,
    this.scheduleStart,
    this.scheduleEnd,
    this.userId,
    this.macAddress,
  });

  GroupModel.fromJson(Map<String, dynamic> json) {
    groupId = json['uuid'];
    groupName = json['name'];
    isActive = json['is_active'] == 1;
    scheduleActive = json['schedule_active'] == 1;
    scheduleStart = json['schedule_start'];
    scheduleEnd = json['schedule_end'];
    userId = json['user_id'];
    macAddress = json['mac_address'];
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
    data['mac_address'] = macAddress;
    return data;
  }

  String formatTimeOfDayToString(TimeOfDay time) {
    return '${time.hour}:${time.minute}';
  }

  @override
  String toString() {
    return 'GroupModel(groupId: $groupId, groupName: $groupName, isActive: $isActive, scheduleActive: $scheduleActive, scheduleStart: $scheduleStart, scheduleEnd: $scheduleEnd, userId: $userId, macAddress: $macAddress)';
  }
}
