import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popcorn_companion/constants/RouteConstants.dart';
import 'package:popcorn_companion/ui/auth_view.dart';
import 'package:popcorn_companion/ui/navigation/home/home_view.dart';
import 'package:popcorn_companion/ui/navigation/navigation_view.dart';

final helloWorldProvider = Provider((_) => 'Hello world');

void main() {
  runApp(
    ProviderScope(
      child: PopcornCompanion(),
    ),
  );
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class PopcornCompanion extends ConsumerWidget {
  const PopcornCompanion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String value = ref.watch(helloWorldProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lazuli',
      navigatorKey: navigatorKey,
      initialRoute: '/',
      theme: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      routes: {
        RouteConstants.navigation: (context) => NavigationView(),
        RouteConstants.home: (context) => HomeView(),
        RouteConstants.auth: (context) => AuthView(),
      },

    );
  }
}
