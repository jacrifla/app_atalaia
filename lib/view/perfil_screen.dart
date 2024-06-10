import 'package:app_atalaia/themes/theme.dart';
import 'package:app_atalaia/utils/routes.dart';
import 'package:flutter/material.dart';
import '../provider/user_provider.dart';
import '../controller/user_controller.dart';
import '../widgets/header.dart';
import '../widgets/menu.dart';
import '../widgets/build_input.dart';
import '../widgets/button_icon.dart';

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

  void _excluirConta() async {
    await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tem certeza de que deseja excluir sua conta?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                final success = await ctlUserController.deleteUser();
                if (success) {
                  _showSuccessSnackbar('Conta excluída com sucesso');
                  Navigator.pushReplacementNamed(context, AppRoutes.login);
                } else {
                  _showErrorSnackbar('Erro ao excluir conta');
                }
              },
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );
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
      _showSuccessSnackbar('Perfil alterado com sucesso');
    } catch (e) {
      _showErrorSnackbar('Erro ao atualizar perfil: $e');
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

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
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
                          labelText: 'Mudar senha',
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.recover);
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
              backgroundColor: appTheme.errorColor,
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
