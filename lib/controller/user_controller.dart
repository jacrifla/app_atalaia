import 'package:flutter/material.dart';
import '../provider/user_provider.dart';
import '../utils/auth_provider.dart';
import '../view/error_screen.dart';

class UserController with ChangeNotifier {
  final UserProvider _userProvider;
  final AuthProvider _authProvider;

  UserController(this._userProvider, this._authProvider);

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Login Method
  Future<void> loginUser(
      BuildContext context, String email, String password) async {
    _setLoading(true);
    try {
      await _userProvider.login(email, password);
      print('UUID após o login: ${_authProvider.userId}');
      Navigator.pushNamed(context, '/loading');
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

  // Signup Method
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

  // Update User Info Method
  Future<void> updateUserInfo(
      {String? name, String? email, String? phone}) async {
    _setLoading(true);
    final userId = _authProvider.userId;

    if (userId == null) {
      _setErrorMessage('UUID do usuário não encontrado');
      return;
    }

    try {
      bool success = await _userProvider.updateUserInfo(
        userId: userId,
        name: name,
        email: email,
        phone: phone,
      );
      if (!success) {
        _setErrorMessage('Falha ao atualizar as informações do usuário');
      }
    } catch (error) {
      _setErrorMessage(error.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Soft Delete User Method
  Future<bool> softDeleteUser() async {
    _setLoading(true);
    final userId = _authProvider.userId;

    if (userId == null) {
      _setErrorMessage('UUID do usuário não encontrado');
      return false;
    }

    try {
      final bool success = await _userProvider.softDelete(userId);
      return success;
    } catch (error) {
      _setErrorMessage('Erro ao excluir usuário: $error');
      return false;
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
}
