import 'package:flutter/material.dart';
import '../provider/user_provider.dart';
import '../utils/routes.dart';
import '../utils/utils.dart';

class UserController extends ChangeNotifier {
  final UserProvider provider;

  UserController({required this.provider});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Map<String, dynamic>? _userData;
  Map<String, dynamic>? get userData => _userData;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _setUserData(Map<String, dynamic>? data) {
    _userData = data;
    notifyListeners();
  }

  Future<void> getUser() async {
    _setLoading(true);
    final userId = provider.getUserId();
    final response = await provider.getUser(userId);
    _setLoading(false);

    if (response['status'] == 'success') {
      _setUserData(response['dados']);
    } else {
      _setErrorMessage(response['msg']);
    }
  }

  Future<void> loginUser(
      BuildContext context, String email, String password) async {
    _setLoading(true);
    final response = await provider.login(email, password);
    _setLoading(false);

    if (response['status'] == 'success') {
      Navigator.pushReplacementNamed(context, AppRoutes.loading);
    } else {
      _setErrorMessage(response['msg']);
    }
  }

  Future<void> createUser(
      String name, String email, String phone, String password) async {
    _setLoading(true);
    final response = await provider.createUser(name, email, phone, password);
    _setLoading(false);

    if (response['status'] == 'success') {
      notifyListeners();
    } else {
      _setErrorMessage(response['msg']);
    }
  }

  Future<void> updateUserInfo(String name, String email, String phone) async {
    _setLoading(true);
    final response = await provider.updateUser(name, email, phone);
    _setLoading(false);

    if (response['status'] == 'success') {
      notifyListeners();
    } else {
      _setErrorMessage(response['msg']);
    }
  }

  Future<void> deleteUser() async {
    _setLoading(true);
    final response = await provider.deleteUser();
    _setLoading(false);

    if (response['status'] == 'success') {
      notifyListeners();
    } else {
      _setErrorMessage(response['msg']);
    }
  }

  Future<void> requestChangePassword(String email) async {
    _setLoading(true);
    final response = await provider.requestChangePassword(email);
    _setLoading(false);

    if (response['status'] == 'success') {
      notifyListeners();
    } else {
      _setErrorMessage(response['msg']);
    }
  }

  Future<void> changePassword(
      String email, String token, String newPassword) async {
    _setLoading(true);
    final response = await provider.changePassword(email, token, newPassword);
    _setLoading(false);

    if (response['status'] == 'success') {
      notifyListeners();
    } else {
      _setErrorMessage(response['msg']);
    }
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

  Future<void> signUpUser(BuildContext context, String name, String email,
      String phone, String password, String confirmPassword) async {
    if (!arePasswordsEqual(password, confirmPassword)) {
      _setErrorMessage('As senhas não correspondem.');
      return;
    }

    if (!isValidEmail(email)) {
      _setErrorMessage('Digite um e-mail válido');
      return;
    }

    if (!isValidPhoneNumber(phone)) {
      _setErrorMessage('Digite um celular válido');
      return;
    }

    if (!validatePassword(password)) {
      _setErrorMessage('A senha deve ter pelo menos 8 caracteres');
      return;
    }

    final response = await provider.createUser(name, email, phone, password);
    if (response['status'] == 'success') {
      _setErrorMessage('Usuário criado com sucesso!');
      notifyListeners();
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      });
    } else {
      _setErrorMessage(response['msg']);
    }
  }
}
