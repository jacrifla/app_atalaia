import 'switch_model.dart';

class GuardModel {
  String? uuid;
  List<SwitchModel>? switches;

  GuardModel({this.uuid, this.switches});

  // Construtor que inicializa um GuardModel a partir de uma lista JSON
  GuardModel.fromJson(List<dynamic> jsonList) {
    if (jsonList.isNotEmpty) {
      uuid = jsonList[0]['guard_id'];
      switches = jsonList
          .map((item) => SwitchModel.fromJson({
                'uuid': item['guard_id'],
                'user_id': null,
                'group_id': null,
                'mac_address': item['mac_address'],
                'name': item['switch_name'],
                'is_active': null,
                'watts': null,
                'guard_active': _parseBool(item['guard_active']),
              }))
          .toList();
    }
  }

  // Converte um GuardModel para um mapa JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['guard_id'] = uuid;
    if (switches != null) {
      data['switches'] = switches!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  // Converte valores diversos para booleano
  static bool _parseBool(dynamic value) {
    if (value is bool) return value;
    if (value is String) return value.toLowerCase() == 'true' || value == '1';
    if (value is int) return value == 1;
    return false;
  }

  @override
  String toString() {
    return 'GuardModel(uuid: $uuid, switches: $switches)';
  }
}
