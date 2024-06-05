import 'package:flutter/material.dart';

import '../provider/user_provider.dart';
import '../controller/user_controller.dart';
import '../utils/routes.dart';

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
  final UserProvider userProvider = UserProvider();
  late final UserController ctlUserController;

  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    ctlUserController = UserController(userProvider);
    _loadUserData();
    super.initState();
  }

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
    final success = await ctlUserController.deleteUser();
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
    final name = _nameController.text;
    final email = _emailController.text;
    final phone = _phoneController.text;

    try {
      await ctlUserController.updateUserInfo(
        name,
        email,
        phone,
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

  void _loadUserData() async {
    try {
      final userData = await ctlUserController.getUser();
      _nameController.text = userData['name'];
      _emailController.text = userData['email'];
      _phoneController.text = userData['phone'];
    } catch (e) {
      print('Erro ao carregar dados do usuário: $e');
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
                            controller: _nameController,
                            validator: (value) {
                              return null;
                            },
                          ),
                          BuildInput(
                            labelText: 'E-mail',
                            icon: const Icon(Icons.email_outlined),
                            controller: _emailController,
                            validator: (value) {
                              return null;
                            },
                          ),
                          BuildInput(
                            labelText: 'Celular',
                            icon: const Icon(Icons.phone_outlined),
                            controller: _phoneController,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ctlUserController.deleteUser();
          // userProvider.delete();
        },
        child: Text('Teste'),
      ),
    );
  }
}
