import 'package:flutter/material.dart';
import '../provider/user_provider.dart';
import '../utils/routes.dart';
import '../utils/utils.dart';

class UserController with ChangeNotifier {
  final UserProvider _userProvider;

  UserController(this._userProvider);

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<Map<String, dynamic>> getUser() async {
    try {
      final userId = _userProvider.getUserId();
      final response = await _userProvider.getUser(userId);
      notifyListeners();
      return response;
    } catch (error) {
      throw 'Erro ao carregar os dados do usuário: $error';
    }
  }

  Future<void> loginUser(
      BuildContext context, String email, String password) async {
    _setLoading(true);
    try {
      await _userProvider.login(email, password);
      Navigator.pushReplacementNamed(context, AppRoutes.loading);
    } catch (error) {
      throw 'Erro no login';
    } finally {
      _setLoading(false);
    }
  }

  Future<void> createUser(
      String name, String email, String phone, String password) async {
    _setLoading(true);
    final response = await provider.createUser(
      name,
      email,
      phone,
      password,
    );
    _setLoading(false);

    if (response['status'] == 'success') {
      notifyListeners();
    } else {
      _setErrorMessage(response['msg']);
    }
  }

  Future<Map<String, dynamic>> updateUserInfo(
    String name,
    String email,
    String phone,
  ) async {
    _setLoading(true);

    try {
      final response = await _userProvider.updateUser(
        name,
        email,
        phone,
      );
      notifyListeners();
      return response;
    } catch (error) {
      throw 'Erro ao atualizar perfil';
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> deleteUser() async {
    _setLoading(true);

    try {
      final bool success = await _userProvider.deleteUser();
      notifyListeners();
      return success;
    } catch (error) {
      throw 'Erro ao excluir conta';
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  void clearError() {
    _setErrorMessage(null);
  }

  bool arePasswordsEqual(String password, String confirmPassword) {
    return password == confirmPassword;
  }

  bool validateEmail(String email) {
    return isValidEmail(email);
  }

  bool validatePhoneNumber(String phoneNumber) {
    return isValidPhoneNumber(phoneNumber);
  }

  bool validatePassword(String password) {
    return password.length >= 8;
  }

  Future<Map<String, dynamic>> signUpUser(
      String name, String email, String phone, String password) async {
    if (!validateEmail(email)) {
      return {'status': 'error', 'message': 'Email inválido'};
    }

    if (!validatePhoneNumber(phone)) {
      return {'status': 'error', 'message': 'Número de telefone inválido'};
    }

    if (!validatePassword(password)) {
      return {
        'status': 'error',
        'message': 'Senha deve ter no mínimo 8 caracteres'
      };
    }

    try {
      final response = await createUser(name, email, phone, password);
      notifyListeners();
      return response['data'];
    } catch (error) {
      return {'status': 'error', 'message': error.toString()};
    }
  }
}
