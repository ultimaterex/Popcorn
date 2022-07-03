


import 'package:flutter/material.dart';

class RoundedInfoComponent extends StatelessWidget {
  const RoundedInfoComponent({Key? key, required this.text, this.icon}) : super(key: key);

  final String text;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.tertiary, borderRadius: const BorderRadius.all(Radius.circular(16))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[icon!, const SizedBox(width: 5)],
          Text(text,),
        ],
      ),
    );
  }
}