
import 'package:popcorn_companion/providers/base_view_model.dart';
import 'package:popcorn_companion/ui/navigation/favourites/favourites_view.dart';
import 'package:popcorn_companion/ui/navigation/home/home_view.dart';
import 'package:popcorn_companion/ui/navigation/explore_people/explore_people_view.dart';
import 'package:popcorn_companion/ui/navigation/explore_shows/explore_shows_view.dart';
import 'package:popcorn_companion/ui/navigation/settings/settings_view.dart';


class NavigationViewModel extends BaseViewModel{

  int currentIndex = 2; // initialize as home

  final screens = [
    const ExploreShowsView(),
    const ExplorePeopleView(),
    const HomeView(),
    const FavouritesView(),
    const SettingsView(),
  ];


  void onNavigation(int index) {
    currentIndex = index;
    notifyListeners();
  }

}