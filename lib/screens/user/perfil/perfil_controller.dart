import 'package:flutter/material.dart';
import 'perfil_provider.dart';

class UserController with ChangeNotifier {
  final UserProvider _userProvider = UserProvider();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> updateUserInfo(
      String name, String userId, String email, String phone) async {
    _setLoading(true);
    try {
      bool success =
          await _userProvider.updateUserInfo(name, userId, email, phone);
      if (!success) {
        _setErrorMessage('Falha ao atualizar as informações do usuário');
      }
    } catch (error) {
      _setErrorMessage(error.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> softDeleteUser(String userId) async {
    _setLoading(true);
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
