import 'package:flutter/material.dart';
import 'package:popcorn_companion/constants/strings.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
    required this.onChanged,
    required this.controller,
    required this.onClear,
  }) : super(key: key);

  final Function(String) onChanged;
  final VoidCallback onClear;

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
        // color: Colors.black26,
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: controller,
            autofocus: false,
            // style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            onChanged: (query) => onChanged(query),
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: theme.colorScheme.tertiary,
                ),
                suffixIcon: controller.text.isNotEmpty
                    ? IconButton(
                        onPressed: onClear,
                        icon: const Icon(Icons.clear),
                      )
                    : null,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: theme.colorScheme.tertiary),
                    borderRadius: BorderRadius.circular(16)),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                hintText: Strings.search,
                hintStyle: theme.textTheme.labelLarge),
          ),
        ));
  }
}
