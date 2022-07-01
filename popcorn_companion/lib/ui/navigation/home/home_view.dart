import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_view_model.dart';

final homeProvider = ChangeNotifierProvider<HomeViewModel>((ref) => HomeViewModel());

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(homeProvider);

    return Scaffold(
      backgroundColor: Colors.black12,
      body: Center(
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            ...newReleases(),
            ...newReleases(),
            ...newReleases(),
          ]),
        ),
      ),
      // bottomNavigationBar: navigation(viewModel),
    );
  }


  Widget navigation(HomeViewModel vm) => BottomNavigationBar(
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

  List<Widget> newReleases() => [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 32, 16, 8),
          child: Text("New Releases",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
        CarouselSlider(
          options: CarouselOptions(height: 150),
          items: [1, 2, 3, 4, 5].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(8)),

                    child: Text(
                      'text $i',
                      style: TextStyle(fontSize: 16.0),
                    ));
              },
            );
          }).toList(),
        )
      ];


}
