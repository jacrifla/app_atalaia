// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class IconTextIconRow extends StatefulWidget {
  final String labelText;
  final Icon startIcon;
  final IconData defaultEndIcon;
  final IconData tappedEndIcon;
  final VoidCallback? onTap;

  const IconTextIconRow({
    super.key,
    required this.labelText,
    required this.startIcon,
    required this.defaultEndIcon,
    required this.tappedEndIcon,
    this.onTap,
  });

  @override
  _IconTextIconRowState createState() => _IconTextIconRowState();
}

class _IconTextIconRowState extends State<IconTextIconRow> {
  late bool _isTapped;

  @override
  void initState() {
    super.initState();
    _isTapped = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isTapped = !_isTapped;
                });
                if (widget.onTap != null) {
                  widget.onTap!();
                }
              },
              child: Row(
                children: [
                  widget.startIcon,
                  const SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      widget.labelText,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Icon(
                    _isTapped ? widget.tappedEndIcon : widget.defaultEndIcon,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20)
      ],
    );
  }
}
