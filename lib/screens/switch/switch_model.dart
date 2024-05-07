class SwitchModel {
  final String name;
  final String macAddress;
  final int watts;
  final bool isActive;

  SwitchModel({
    required this.name,
    required this.macAddress,
    required this.watts,
    required this.isActive,
  });

  factory SwitchModel.fromJson(Map<String, dynamic> json) {
    return SwitchModel(
      name: json['name'],
      macAddress: json['mac_address'],
      watts: json['watts'],
      isActive: json['is_active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'mac_address': macAddress,
      'watts': watts,
      'is_active': isActive,
    };
  }
}
