import '../provider/signup_provider.dart';

class SignupController {
  final SignupProvider _signupProvider = SignupProvider();

  Future<Map<String, dynamic>> createUser(
      String name, String email, String phone, String password) async {
    try {
      return await _signupProvider.createUser(name, email, phone, password);
    } catch (error) {
      return {'status': 'error', 'msg': error.toString()};
    }
  }
}
