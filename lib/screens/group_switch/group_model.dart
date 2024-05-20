import 'package:flutter/material.dart';

class GroupModel {
  final String groupId;
  final String groupName;
  final IconData groupIcon;
  final bool? groupCommon;
  final bool randomTime;
  final bool keepActive;
  final int? keepActiveHours;
  final bool autoActivationTime;
  final String? activationStartTime;
  final String? activationEndTime;
  final bool isActive;

  GroupModel({
    required this.groupId,
    required this.groupName,
    required this.groupIcon,
    this.groupCommon,
    required this.randomTime,
    required this.keepActive,
    this.keepActiveHours,
    required this.autoActivationTime,
    this.activationStartTime,
    this.activationEndTime,
    this.isActive = false,
  });
}
