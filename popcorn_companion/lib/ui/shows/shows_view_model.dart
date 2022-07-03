import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:popcorn_companion/constants/hives.dart';
import 'package:popcorn_companion/models/api/episode.dart';
import 'package:popcorn_companion/models/api/show.dart';
import 'package:popcorn_companion/providers/base_view_model.dart';
import 'package:popcorn_companion/providers/repositories/show_box_repository.dart';
import 'package:popcorn_companion/providers/services/api_service.dart';

final showProvider = ChangeNotifierProvider<ShowViewModel>((ref) => ShowViewModel(ref));

class ShowViewModel extends BaseViewModel {
  final ChangeNotifierProviderRef ref;

  bool favourited = false;

  late final Box<Show> box;

  ShowViewModel(this.ref) {
    box = Hive.box(Hives.favouriteShowsBox);
  }

  Show? show;

  Future<bool> initialize(show) async {
    clear();
    this.show = show;
    favourited = ref.watch(favouriteShowBoxProvider(box)).getFavouriteStatus(show);
    notifyListeners();
    await getEpisodes();
    return true;
  }

  void clear() {
    favourited = false;
    show = null;
    episodes = [];
  }

  List<Episode> episodes = [];

  Future getEpisodes() async {
    final result = await ref.watch(apiProvider).getEpisodes("${show?.id.toString()}");
    episodes = result;
    notifyListeners();
  }

  void toggleFavouriteShow() {
    final showBox = ref.watch(favouriteShowBoxProvider(box));
    if (favourited) {
      showBox.removeShowFromFavourites(show!);
    } else {
      showBox.addShowToFavourites(show!);
    }

    favourited = showBox.getFavouriteStatus(show!);
    notifyListeners();
  }
}
