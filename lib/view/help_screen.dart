// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../widgets/header.dart';
import 'topic_content_screen.dart';
import '../screens/help/topics.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
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
      appBar: const Header(
        title: 'Ajuda',
        icon: Icons.help,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Pesquisar',
                    prefixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                  controller: _inputPesquisar,
                  onChanged: _filterTopics,
                ),
              ),
              const SizedBox(height: 20),
              for (var topic in filteredTopics)
                GestureDetector(
                  onTap: () => _showTopicContent(context, topic),
                  child: Card(
                    color: Theme.of(context).colorScheme.primary,
                    elevation: 5,
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            topic['title']!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _truncateWithEllipsis(topic['content']!),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _truncateWithEllipsis(String text) {
    const maxLength = 100;
    return text.length > maxLength
        ? '${text.substring(0, maxLength)}...'
        : text;
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

  void _showTopicContent(BuildContext context, Map<String, String> topic) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TopicContentScreen(
          title: topic['title']!,
          content: topic['content']!,
        ),
      ),
    );
  }
}
