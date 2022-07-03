import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popcorn_companion/ui/navigation/navigation_view_model.dart';

final navigationProvider = ChangeNotifierProvider<NavigationViewModel>((ref) => NavigationViewModel());

class NavigationView extends ConsumerStatefulWidget {
  const NavigationView({Key? key}) : super(key: key);

  @override
  NavigationViewState createState() => NavigationViewState();
}

class NavigationViewState extends ConsumerState<NavigationView> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; //Declared as true as to not wipe view state

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final viewModel = ref.watch(navigationProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
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
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: vm.currentIndex,
        onTap: (index) => vm.onNavigation(index),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Explore Shows'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Explore People'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Favourites'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      );
}
