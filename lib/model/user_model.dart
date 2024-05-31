import 'package:get_storage/get_storage.dart';

class UserModel {
  String? userId;
  String? name;
  String? email;
  String? phone;
  String? passwordHash;
  final box = GetStorage();

  UserModel({
    this.userId,
    this.name,
    this.email,
    this.phone,
    this.passwordHash,
  });

  // Método para salvar o usuario
  void save() {
    box.write('user', toJson());
  }

  // Método para carregar o usuario
  UserModel? load() {
    final userData = box.read('user');
    if (userData != null) {
      return UserModel.fromJson(userData);
    }
    return null;
  }

  // Construtor que converte um mapa JSON em uma instância de UserModel
  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['uuid'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    passwordHash = json['password_hash'];
  }

  // Método que converte uma instância de UserModel em um mapa JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = userId;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['password_hash'] = passwordHash;
    return data;
  }
}
