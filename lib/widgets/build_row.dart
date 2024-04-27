import 'package:flutter/material.dart';

class BuildRow extends StatelessWidget {
  final String labelText;
  final Icon icon;
  final VoidCallback? onTap;

  const BuildRow({
    Key? key,
    required this.labelText,
    this.icon = const Icon(Icons.person_add_alt_outlined),
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              icon,
              const SizedBox(width: 20),
              Stack(
                children: [
                  Text(
                    labelText,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  // Para fazer o sublinhado
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 17,
                    child: Container(
                      height: 1.5, // Altura do sublinhado
                      color: Theme.of(context)
                          .colorScheme
                          .primary, // Cor do sublinhado
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
