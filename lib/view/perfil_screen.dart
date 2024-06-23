import 'package:flutter/material.dart';
import '../provider/user_provider.dart';
import '../controller/user_controller.dart';
import '../utils/routes.dart';
import '../widgets/header.dart';
import '../widgets/menu.dart';
import '../widgets/build_input.dart';
import '../widgets/button_icon.dart';
import '../themes/theme.dart';
import 'recover_screen.dart';

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
    ctlUserController = UserController(provider: userProvider);
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
                await ctlUserController.deleteUser();
                if (ctlUserController.errorMessage == null) {
                  _showSnackbar('Conta excluída com sucesso', isError: false);
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.login,
                    (Route<dynamic> route) => false,
                  );
                } else {
                  _showSnackbar(ctlUserController.errorMessage!, isError: true);
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

    await ctlUserController.updateUserInfo(name, email, phone);
    if (ctlUserController.errorMessage == null) {
      _showSnackbar('Perfil alterado com sucesso', isError: false);
    } else {
      _showSnackbar(ctlUserController.errorMessage!, isError: true);
    }
  }

  void _loadUserData() async {
    await ctlUserController.getUser();
    if (ctlUserController.errorMessage == null) {
      final userData = ctlUserController.userData;
      _nameController.text = userData?['name'] ?? '';
      _emailController.text = userData?['email'] ?? '';
      _phoneController.text = userData?['phone'] ?? '';
    } else {
      _showSnackbar(ctlUserController.errorMessage!, isError: true);
    }
  }

  void _showSnackbar(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    RecoverScreen(email: _emailController.text),
                              ),
                            );
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
              backgroundColor: appTheme.colorScheme.error,
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
