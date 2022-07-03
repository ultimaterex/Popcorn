import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:popcorn_companion/constants/hives.dart';
import 'package:popcorn_companion/constants/routes.dart';
import 'package:popcorn_companion/main.dart';
import 'package:popcorn_companion/models/api/show.dart';
import 'package:popcorn_companion/providers/base_view_model.dart';
import 'package:popcorn_companion/providers/repositories/show_box_repository.dart';

final favouritesProvider = ChangeNotifierProvider<FavouritesViewModel>((ref) => FavouritesViewModel(ref));

class FavouritesViewModel extends BaseViewModel {
  FavouritesViewModel(this.ref);

  final ChangeNotifierProviderRef ref;
  late Box<Show> box;

  List<Show> favourites = [];

  Future<bool> initialize() async {
    box = Hive.box(Hives.favouriteShowsBox);

    getFavourites();
    return true;
  }

  getFavourites() {
    favourites = ref.watch(favouriteShowBoxProvider(box)).getAllFavourites();
    notifyListeners();
  }

  navigateToShow(BuildContext context, Show show) {
    FocusScope.of(context).unfocus();
    navigatorKey.currentState?.pushNamed(Routes.show, arguments: show).then((value) => getFavourites());
  }
}
