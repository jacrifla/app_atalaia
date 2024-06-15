import 'switch_model.dart';

class GuardModel {
  String? uuid;
  List<SwitchModel>? switches;

  GuardModel({this.uuid, this.switches});

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
                'guard_active': item['guard_active'],
              }))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['guard_id'] = uuid;
    if (switches != null) {
      data['switches'] = switches!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'GuardModel(uuid: $uuid, switches: $switches)';
  }
}
