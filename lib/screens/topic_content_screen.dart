import 'package:app_atalaia/widgets/header.dart';
import 'package:flutter/material.dart';

class TopicContentScreen extends StatelessWidget {
  final String title;
  final String content;

  const TopicContentScreen({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: title),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          content,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
