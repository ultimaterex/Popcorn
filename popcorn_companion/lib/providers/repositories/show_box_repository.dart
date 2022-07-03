
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:popcorn_companion/models/api/show.dart';



final favouriteShowBoxProvider = Provider.family<FavouriteShowBoxRepository, Box<Show>>((ref, box) => FavouriteShowBoxRepository(box));


class FavouriteShowBoxRepository {
  const FavouriteShowBoxRepository(this._box);

  final Box<Show> _box;

  void addShowToFavourites(Show show) async {
    await _box.put(show.id, show);
  }

  bool getFavouriteStatus(Show show) {
    // Get info from explore_people box
    return _box.containsKey(show.id);
  }

  removeShowFromFavourites(Show show) {
    _box.delete(show.id);
  }

  List<Show> getAllFavourites()  {
    return _box.values.toList();
  }

}