import 'package:flutter/material.dart';

class ToolbarButton extends StatelessWidget {
  const ToolbarButton({
    Key? key,
    required this.button,
  }) : super(key: key);

  final IconButton button;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.black54.withOpacity(0.7),
          ),
          child: button),
    );
  }
}
