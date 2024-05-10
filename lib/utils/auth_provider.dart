import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class AuthProvider extends ChangeNotifier {
  // Criando uma instancia
  final box = GetStorage();

  String? get userId => box.read('uuid');

  void setUserId(String userId) {
    box.write('uuid', userId);
    notifyListeners();
  }
}
