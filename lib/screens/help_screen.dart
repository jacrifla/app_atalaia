// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../widgets/header.dart';
import 'topic_content_screen.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final List<Map<String, String>> topics = [
    {
      'title': 'Como criar conta',
      'content':
          'Para criar uma conta, vá para a tela de registro e preencha seus detalhes.',
    },
    {
      'title': 'Configurando para o primeiro uso',
      'content':
          'Após criar uma conta, você será guiado por um assistente de configuração para configurar o aplicativo para o primeiro uso.',
    },
    {
      'title': 'Perfil',
      'content':
          'No seu perfil, você pode visualizar e editar suas informações pessoais e preferências.',
    },
    {
      'title': 'Grupos',
      'content':
          'Os Presets são um sistema que permite ao usuário comandar diversos Pontos de Iluminação por vez. Eles podem ser acionados de diversas maneiras: Através de um comando feito pelo usuário; Através de um horário e/ou dia da semana pré-estabelecido; Comando de emergência (no caso de Presets de Guarda).',
    },
    {
      'title': 'Pontos',
      'content':
          'Para adicionar um novo ponto, vá para a tela "Criar Ponto". Insira um nome único para o ponto no campo "Nome do Ponto" e o endereço MAC do dispositivo associado ao ponto no campo "MAC Address". Em seguida, clique no botão de marca de verificação para salvar as informações do ponto.',
    },
  ];

  final TextEditingController _inputPesquisar = TextEditingController();
  List<Map<String, String>> filteredTopics = [];

  @override
  void initState() {
    super.initState();
    filteredTopics = topics;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(title: 'Ajuda'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 100,
              child: Icon(
                Icons.school,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Pesquisar',
                  prefixIcon: Icon(Icons.search),
                ),
                controller: _inputPesquisar,
                onChanged: (value) {
                  _filterTopics(value);
                },
              ),
            ),
            const SizedBox(height: 20),
            for (var topic in filteredTopics)
              GestureDetector(
                onTap: () {
                  _showTopicContent(
                      context, topic['title']!, topic['content']!);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        topic['title']!,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Visibility(
                        visible: false,
                        child: Text(
                          topic['content']!,
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _filterTopics(String query) {
    setState(() {
      filteredTopics = topics.where((topic) {
        final title = topic['title']!.toLowerCase();
        final content = topic['content']!.toLowerCase();
        return title.contains(query.toLowerCase()) ||
            content.contains(query.toLowerCase());
      }).toList();
    });
  }

  void _showTopicContent(BuildContext context, String title, String content) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            TopicContentScreen(title: title, content: content),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: HelpScreen()));
}
