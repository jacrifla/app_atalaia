// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/auth_provider.dart';
import 'confirmation_screen.dart';
import '../screens/user/perfil/perfil_controller.dart';

import '../widgets/header.dart';
import '../widgets/menu.dart';
import '../widgets/build_input.dart';
import '../widgets/button_icon.dart';
import 'success_screen.dart';
import 'error_screen.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final TextEditingController _inputNome = TextEditingController();
  final TextEditingController _inputEmail = TextEditingController();
  final TextEditingController _inputCel = TextEditingController();

  void _excluirConta() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ConfirmationScreen(
          question: 'Tem certeza de que deseja excluir sua conta?',
          onConfirm: () async {
            Navigator.pushNamed(context, '/perfil');
            _excluirContaConfirmed();
          },
          onCancel: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void _excluirContaConfirmed() async {
    final userController = Provider.of<UserController>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userId = authProvider.userId;

    if (userId == null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ErrorScreen(
            message: 'Erro',
            errorDescription: 'UUID do usuário não encontrado',
          ),
        ),
      );
      return;
    }

    try {
      bool success = await userController.softDeleteUser(userId);
      print(success);
      print('USER ID PERFIL: $userId');
      if (success) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SuccessScreen(
              message: 'Conta excluída com sucesso',
              alternativeRoute: '/',
            ),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const ErrorScreen(
              message: 'Erro ao excluir conta',
              errorDescription: 'Falha ao excluir a conta',
            ),
          ),
        );
      }
    } catch (error) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ErrorScreen(
            message: 'Erro ao excluir conta',
            errorDescription: error.toString(),
          ),
        ),
      );
    }
  }

  void _confirmarAlteracoes() async {
    if (_formState.currentState!.validate()) {
      final userController =
          Provider.of<UserController>(context, listen: false);
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final name = _inputNome.text;
      final userId = authProvider.userId;
      final email = _inputEmail.text;
      final phone = _inputCel.text;

      if (userId == null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const ErrorScreen(
              message: 'Erro',
              errorDescription: 'UUID do usuário não encontrado',
            ),
          ),
        );
        return;
      }

      try {
        await userController.updateUserInfo(name, userId, email, phone);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SuccessScreen(
              message: 'Perfil alterado com sucesso',
              alternativeRoute: '/perfil',
            ),
          ),
        );
      } catch (e) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ErrorScreen(
              message: 'Erro ao atualizar perfil',
              errorDescription: e.toString(),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(title: 'Perfil'),
      endDrawer: const MenuDrawer(),
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const Text(
                      'Deseja alterar as configurações da sua conta de usuário?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: _formState,
                      child: Column(
                        children: [
                          BuildInput(
                            labelText: 'Nome',
                            controller: _inputNome,
                          ),
                          BuildInput(
                            labelText: 'E-mail',
                            icon: const Icon(Icons.email_outlined),
                            controller: _inputEmail,
                          ),
                          BuildInput(
                            labelText: 'Celular',
                            icon: const Icon(Icons.phone_outlined),
                            controller: _inputCel,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonIcon(
                          backgroundColor:
                              Theme.of(context).colorScheme.onSecondary,
                          labelText: 'Mudar senha',
                          onPressed: () {
                            if (_formState.currentState!.validate()) {
                              Navigator.pushNamed(
                                  context, '/recover_confirmation');
                            }
                          },
                        ),
                        ButtonIcon(
                          onPressed: _confirmarAlteracoes,
                          labelText: 'Confirmar',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: ButtonIcon(
              backgroundColor: Colors.redAccent[200],
              icon: const Icon(Icons.delete_outline_outlined),
              labelText: 'Deletar conta',
              onPressed: _excluirConta,
            ),
          ),
        ],
      ),
    );
  }
}
