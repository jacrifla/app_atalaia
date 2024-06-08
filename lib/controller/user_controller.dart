// ignore_for_file: use_build_context_synchronously

import 'package:app_atalaia/utils/routes.dart';
import 'package:flutter/material.dart';
import '../provider/user_provider.dart';
import '../utils/utils.dart';
import '../view/error_screen.dart';

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
      Navigator.pushNamed(context, AppRoutes.loading);
    } catch (error) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ErrorScreen(
            message: 'Erro no login',
            errorDescription: error.toString(),
            onOKPressed: () => Navigator.pop(context),
          ),
        ),
      );
    } finally {
      _setLoading(false);
    }
  }

  Future<Map<String, dynamic>> createUser(
      String name, String email, String phone, String password) async {
    _setLoading(true);
    try {
      return await _userProvider.createUser(name, email, phone, password);
    } catch (error) {
      return {'status': 'error', 'msg': error.toString()};
    } finally {
      _setLoading(false);
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
      print(response);
      return response;
    } catch (error) {
      _setErrorMessage(error.toString());
    } finally {
      _setLoading(false);
    }
    return {};
  }

  Future<bool> deleteUser() async {
    _setLoading(true);

    try {
      final bool success = await _userProvider.deleteUser();
      return success;
    } catch (error) {
      // _setErrorMessage('Erro ao excluir usuário: $error');
      return false;
    } finally {
      // _setLoading(false);
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
      return response['data'];
    } catch (error) {
      return {'status': 'error', 'message': error.toString()};
    }
  }
}
