class GuardModel {
  String? uuid;
  String? userId;
  String? isActive;

  GuardModel({this.uuid, this.userId, this.isActive});

  GuardModel.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    userId = json['user_id'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['user_id'] = userId;
    data['is_active'] = isActive;
    return data;
  }
}
