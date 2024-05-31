class SwitchModel {
  String? uuid;
  String? userId;
  String? groupId;
  String? macAddress;
  String? name;
  bool? isActive;
  int? watts;
  bool? guardActive;

  SwitchModel({
    this.uuid,
    this.userId,
    this.groupId,
    this.macAddress,
    this.name,
    this.isActive,
    this.watts,
    this.guardActive,
  });

  SwitchModel.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    userId = json['user_id'];
    groupId = json['group_id'];
    macAddress = json['mac_address'];
    name = json['name'];
    isActive = _parseBool(json['is_active']);
    watts = _parseInt(json['watts']);
    guardActive = _parseBool(json['guard_active']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['user_id'] = userId;
    data['group_id'] = groupId;
    data['mac_address'] = macAddress;
    data['name'] = name;
    data['is_active'] = isActive;
    data['watts'] = watts;
    data['guard_active'] = guardActive;
    return data;
  }

  bool? _parseBool(dynamic value) {
    if (value is bool) {
      return value;
    } else if (value is int) {
      return value == 1;
    } else if (value is String) {
      return value.toLowerCase() == 'true' || value == '1';
    }
    return null;
  }

  int? _parseInt(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is String) {
      return int.tryParse(value);
    }
    return null;
  }

  @override
  String toString() {
    return 'SwitchModel(uuid: $uuid, userId: $userId, groupId: $groupId, macAddress: $macAddress, name: $name, isActive: $isActive, watts: $watts, guardActive: $guardActive)';
  }
}
