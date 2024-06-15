import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class AuthProvider extends ChangeNotifier {
  final box = GetStorage();

  String? get userId => box.read('uuid');
  String? get guardId => box.read('uuid');

  void setUserId(String userId) {
    box.write('uuid', userId);
    notifyListeners();
  }

  void setGuardId(String guardId) {
    box.write('uuid', guardId);
    notifyListeners();
  }

  bool isAuthenticated() {
    return userId != null;
  }
}
