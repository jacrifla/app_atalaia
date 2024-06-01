// ignore_for_file: use_build_context_synchronously

import 'package:app_atalaia/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/user_controller.dart';

import '../widgets/header.dart';
import '../widgets/menu.dart';
import '../widgets/build_input.dart';
import '../widgets/button_icon.dart';
import 'confirmation_screen.dart';
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
            Navigator.pushNamed(context, AppRoutes.userProfile);
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
    final success = await userController.softDeleteUser();
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
  }

  void _confirmarAlteracoes() async {
    final userController = Provider.of<UserController>(context, listen: false);

    final name = _inputNome.text.isNotEmpty ? _inputNome.text : null;
    final email = _inputEmail.text.isNotEmpty ? _inputEmail.text : null;
    final phone = _inputCel.text.isNotEmpty ? _inputCel.text : null;

    if (name == null && email == null && phone == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nenhuma alteração para salvar')),
      );
      return;
    }

    try {
      await userController.updateUserInfo(
        name: name,
        email: email,
        phone: phone,
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const SuccessScreen(
            message: 'Perfil alterado com sucesso',
            alternativeRoute: AppRoutes.userProfile,
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
                            validator: (value) {
                              return null;
                            },
                          ),
                          BuildInput(
                            labelText: 'E-mail',
                            icon: const Icon(Icons.email_outlined),
                            controller: _inputEmail,
                            validator: (value) {
                              return null;
                            },
                          ),
                          BuildInput(
                            labelText: 'Celular',
                            icon: const Icon(Icons.phone_outlined),
                            controller: _inputCel,
                            validator: (value) {
                              return null;
                            },
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
                            Navigator.pushNamed(
                                context, '/recover_confirmation');
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
