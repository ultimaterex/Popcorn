import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popcorn_companion/constants/colors.dart';

//Theme Providers
final changeTheme = ChangeNotifierProvider.autoDispose((ref) {
  return ChangeThemeState();
});

class PopcornTheme {
  ///colors for light mode
  static final lightTheme = ThemeData(
    primaryColor: ColorsConstants.primaryLight,
    backgroundColor: ColorsConstants.secondaryLight,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      // secondary: ColorsConstants.accent,
      tertiary: ColorsConstants.tertiaryLight,
    ),
    // secondary colour
    scaffoldBackgroundColor: ColorsConstants.secondaryLight,
    canvasColor: Colors.transparent,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorsConstants.accent,
        unselectedItemColor: ColorsConstants.tertiaryLight,
        selectedItemColor: ColorsConstants.secondaryLight),

    primaryTextTheme: Typography().black.copyWith(
        titleSmall: TextStyle(color: ColorsConstants.tertiaryLight),
        labelMedium: TextStyle(color: ColorsConstants.tertiaryLight),
        labelLarge: TextStyle(color: ColorsConstants.tertiaryLight)),


    textTheme: Typography().black,

    iconTheme: IconThemeData(color: ColorsConstants.primaryLight),
  );

  /// colors for dark mode
  static final darkTheme = ThemeData(
    backgroundColor: ColorsConstants.secondaryDark,
    primaryColor: ColorsConstants.primaryDark,
    colorScheme:
        ColorScheme.fromSwatch().copyWith(
            // secondary: ColorsConstants.accent,
            tertiary: ColorsConstants.tertiaryDark),
    scaffoldBackgroundColor: ColorsConstants.secondaryDark,
    canvasColor: Colors.transparent,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: ColorsConstants.tertiaryDark,
    ),
    primaryTextTheme: Typography().white,

    textTheme: Typography().white.copyWith(
        titleSmall: TextStyle(color: ColorsConstants.tertiaryDark),
        labelMedium: TextStyle(color: ColorsConstants.tertiaryDark),
        labelLarge: TextStyle(color: ColorsConstants.tertiaryDark)),

    iconTheme: IconThemeData(color: ColorsConstants.primaryDark),
  );
}

// Dark mode by default
class ChangeThemeState extends ChangeNotifier {
  bool darkMode = true;

  void enableDarkMode() {
    darkMode = true;
    notifyListeners();
  }

  void enableLightMode() {
    darkMode = false;
    notifyListeners();
  }

  void toggle() {
    darkMode = !darkMode;
    notifyListeners();
  }
}
