class SwitchModel {
  int? id;
  String? uuid;
  int? userId;
  dynamic groupId;
  String? macAddress;
  String? name;
  bool? isActive;
  int? watts;
  bool? guardActive;

  SwitchModel({
    this.id,
    this.uuid,
    this.userId,
    this.groupId,
    this.macAddress,
    this.name,
    this.isActive,
    this.watts,
    this.guardActive,
  });

  // Construtor que inicializa um SwitchModel a partir de um JSON
  SwitchModel.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    userId = _parseInt(json['user_id']);
    groupId = _parseInt(json['group_id']);
    macAddress = json['mac_address'];
    name = json['name'];
    isActive = _parseBool(json['is_active']);
    watts = _parseInt(json['watts']);
    guardActive = _parseBool(json['guard_active']);
  }

  // Converte um SwitchModel para um mapa JSON
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

  // Converte valores diversos para booleano
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

  // // Converte um valor dinâmico para inteiro, se possível
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
