import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:popcorn_companion/PopcornTheme.dart';
import 'package:popcorn_companion/constants/hives.dart';
import 'package:popcorn_companion/providers/repositories/settings_box_repository.dart';

final settingsProvider = ChangeNotifierProvider<SettingsService>((ref) => SettingsService(ref));

class SettingsService with ChangeNotifier {
  final ChangeNotifierProviderRef ref;
  late Box box;

  SettingsService(this.ref) {
    box = Hive.box(Hives.settingsBox);
  }

  void initialize() {
    _loadTheme();
  }

  bool currentTheme = true;

  // Loads Theme From Box
  void _loadTheme() {
    currentTheme = ref.watch(settingsShowBoxProvider(box)).getTheme();
    final themeProvider = ref.read(changeTheme);

    if (currentTheme) {
      themeProvider.enableDarkMode();
    } else {
      themeProvider.enableLightMode();
    }
    notifyListeners();
  }

  // Saves Theme in Box
  void _setTheme(bool theme) {
    final settingsBox = ref.watch(settingsShowBoxProvider(box));
    settingsBox.registerTheme(theme);
  }

  // Toggles Theme, saves it and loads the Theme
  void toggle() {
    // assumes there's only 2 states for now
    final settingsBox = ref.watch(settingsShowBoxProvider(box));
    _setTheme(!settingsBox.getTheme());
    _loadTheme();
  }


}
