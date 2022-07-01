import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popcorn_companion/ui/navigation/navigation_view_model.dart';

final navigationProvider = ChangeNotifierProvider<NavigationViewModel>((ref) => NavigationViewModel());

class NavigationView extends ConsumerWidget {
  const NavigationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(navigationProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) => SharedAxisTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
          child: child,
        ),
        child: viewModel.screens[viewModel.currentIndex],
      ),
      bottomNavigationBar: navigation(viewModel),
    );
  }

  Widget navigation(NavigationViewModel vm) => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black38,
        unselectedItemColor: Colors.white60,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: vm.currentIndex,
        onTap: (index) => vm.onNavigation(index),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'People'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Favourites'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      );
}
