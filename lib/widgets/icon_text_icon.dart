import 'package:flutter/material.dart';

class IconTextIconRow extends StatefulWidget {
  final String labelText;
  final Icon startIcon;
  final IconData defaultEndIcon;
  final IconData tappedEndIcon;
  final VoidCallback? onTap;
  final Color backgroundColor;

  const IconTextIconRow({
    Key? key,
    required this.labelText,
    required this.startIcon,
    required this.defaultEndIcon,
    required this.tappedEndIcon,
    this.onTap,
    this.backgroundColor = const Color(0xFF446D9D),
  }) : super(key: key);

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
            color: widget.backgroundColor,
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
                      style: const TextStyle(
                          fontSize: 16.0,
                          color: Color(0xFFF5F5F5),
                          fontWeight: FontWeight.bold),
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
