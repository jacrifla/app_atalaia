class SwitchModel {
  final String? id;
  final String? uuid;
  final String? userId;
  final String? iconName;
  final String? groupId;
  final String macAddress;
  final String name;
  final bool isActive;
  final String? lastTimeActive;
  final int watts;
  final bool? keepActive;
  final bool? scheduleActive;
  final String? scheduleLastActivation;
  final String? scheduleStart;
  final String? scheduleEnd;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final bool? guardActive;

  SwitchModel({
    this.id,
    this.uuid,
    this.userId,
    this.iconName,
    this.groupId,
    required this.macAddress,
    required this.name,
    required this.isActive,
    this.lastTimeActive,
    required this.watts,
    this.keepActive,
    this.scheduleActive,
    this.scheduleLastActivation,
    this.scheduleStart,
    this.scheduleEnd,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.guardActive,
  });

  factory SwitchModel.fromJson(Map<String, dynamic> json) {
    return SwitchModel(
      id: json['id'],
      uuid: json['uuid'],
      userId: json['user_id'],
      iconName: json['icon_name'],
      groupId: json['group_id'],
      macAddress: json['mac_address'],
      name: json['name'],
      isActive: json['is_active'] == "1",
      lastTimeActive: json['last_time_active'],
      watts: int.parse(json['watts']),
      keepActive: json['keep_active'] == "1",
      scheduleActive: json['schedule_active'] == "1",
      scheduleLastActivation: json['schedule_last_activation'],
      scheduleStart: json['schedule_start'],
      scheduleEnd: json['schedule_end'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      guardActive: json['guard_active'] == "1",
    );
  }
}
