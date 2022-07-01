



import 'package:flutter/material.dart';
import 'package:popcorn_companion/services/providers/base_view_model.dart';
import 'package:popcorn_companion/ui/navigation/favourites/favourites_view.dart';
import 'package:popcorn_companion/ui/navigation/home/home_view.dart';
import 'package:popcorn_companion/ui/navigation/people/people_view.dart';
import 'package:popcorn_companion/ui/navigation/search/search_view.dart';
import 'package:popcorn_companion/ui/navigation/settings/settings_view.dart';


class NavigationViewModel extends BaseViewModel{

  int currentIndex = 0;

  final screens = [
    const HomeView(),
    const SearchView(),
    const PeopleView(),
    const FavouritesView(),
    const SettingsView(),
  ];


  void onNavigation(int index) {
    currentIndex = index;
    notifyListeners();
  }

}