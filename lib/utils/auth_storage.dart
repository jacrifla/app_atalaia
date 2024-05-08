import 'package:get_storage/get_storage.dart';

class AuthStorage {
  static final _box = GetStorage();

  static Future<void> saveUserId(String userId) async {
    print('UUID recebido para salvar: $userId');
    await _box.write('userId', userId);
  }

  static String? getUserId() {
    return _box.read('userId');
  }

  static Future<String?> readUuid() async {
    return getUserId();
  }
}
