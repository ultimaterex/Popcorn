import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:popcorn_companion/PopcornTheme.dart';
import 'package:popcorn_companion/constants/hives.dart';
import 'package:popcorn_companion/constants/routes.dart';
import 'package:popcorn_companion/models/api/image.dart';
import 'package:popcorn_companion/models/api/show.dart';
import 'package:popcorn_companion/providers/services/settings_service.dart';
import 'package:popcorn_companion/ui/auth_view.dart';
import 'package:popcorn_companion/ui/navigation/home/home_view.dart';
import 'package:popcorn_companion/ui/navigation/navigation_view.dart';
import 'package:popcorn_companion/ui/people/people_view.dart';

import 'models/api/schedule.dart';
import 'ui/shows/shows_view.dart';

Future<void> main() async {
  await initializeHive();
  runApp(
    const ProviderScope(
      child: PopcornCompanion(),
    ),
  );
}

Future<void> initializeHive() async {
  await Hive.initFlutter();

  // Order is important here
  Hive.registerAdapter(ScheduleAdapter());
  Hive.registerAdapter(ImageAdapter());
  Hive.registerAdapter(ShowAdapter());

  await Hive.openBox<Show>(Hives.favouriteShowsBox);
  await Hive.openBox(Hives.settingsBox);


}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class PopcornCompanion extends ConsumerWidget {
  const PopcornCompanion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(changeTheme);

    final settings = ref.watch(settingsProvider);

    // Load on next tick
    Future.delayed(Duration.zero, () async {
      settings.initialize();
    });

    return MaterialApp(
      theme: PopcornTheme.lightTheme,
      darkTheme: PopcornTheme.darkTheme,
      themeMode: currentTheme.darkMode ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      title: 'Popcorn',
      navigatorKey: navigatorKey,
      initialRoute: '/',
      routes: {
        Routes.navigation: (context) => const NavigationView(),
        Routes.home: (context) => const HomeView(),
        Routes.auth: (context) => const AuthView(),
        Routes.show: (context) => const ShowsView(),
        Routes.people: (context) => const PeopleView(),
      },
    );
  }


}
