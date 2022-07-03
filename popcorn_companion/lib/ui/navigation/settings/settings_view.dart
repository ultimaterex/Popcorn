import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popcorn_companion/constants/strings.dart';
import 'package:popcorn_companion/providers/services/settings_service.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsService = ref.watch(settingsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 8),
                child: Text(
                  Strings.settings,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    Strings.darkMode,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 20),
                  Switch(
                    value: settingsService.currentTheme,
                    onChanged: (val) => settingsService.toggle(),
                  ),
                ]),
              ),
            ]),
      ),
      // bottomNavigationBar: navigation(),
    );
  }
}
