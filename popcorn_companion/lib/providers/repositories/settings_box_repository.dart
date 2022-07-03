import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:popcorn_companion/constants/hives.dart';

final settingsShowBoxProvider = Provider.family<SettingsShowBoxRepository, Box>((ref, box) => SettingsShowBoxRepository(box));


class SettingsShowBoxRepository {
  const SettingsShowBoxRepository(this._box);

  final Box _box;

  // assumes 2 themes for now, expand to int
  void registerTheme(bool theme) async {
      _box.put(Hives.themeSettingsKey, theme);
  }

  bool getTheme() {
    return _box.get(Hives.themeSettingsKey, defaultValue: true);
  }


}