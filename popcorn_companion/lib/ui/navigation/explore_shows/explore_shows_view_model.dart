import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popcorn_companion/constants/routes.dart';
import 'package:popcorn_companion/main.dart';
import 'package:popcorn_companion/models/api/show.dart';
import 'package:popcorn_companion/providers/services/api_service.dart';
import 'package:popcorn_companion/providers/base_view_model.dart';

final exploreShowsProvider = ChangeNotifierProvider<ExploreShowsViewModel>((ref) => ExploreShowsViewModel(ref));

class ExploreShowsViewModel extends BaseViewModel {
  final ChangeNotifierProviderRef ref;

  ExploreShowsViewModel(this.ref) {
    exploreLoader = true;
    getExploreEpisodes(_page);

    notifyListeners();
  }

  int _page = 0;

  List<Show> searchShows = [];
  bool searchLoader = false;

  List<Show> exploreShows = [];
  bool exploreLoader = false;

  bool searchMode = false; // used for hiding related categories while explore_shows is true
  Timer? _debounce;

  final scrollController = ScrollController();
  final searchController = TextEditingController();

  void search(String query) {
    searchMode = query.isEmpty ? false : true;
    notifyListeners();

    if (!searchMode) return; //return if empty Query

    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () async {
      searchLoader = true;
      notifyListeners();

      final result = await ref.watch(apiProvider).searchShows(query);
      searchShows = result.map((e) => e.show).toList();

      searchLoader = false;
      notifyListeners();
    });
  }

  Future<void> getExploreEpisodes(int page) async {
    final result = await ref.watch(apiProvider).getShowsFromIndexByPage(page);
    exploreShows.addAll(result);
    exploreLoader = false;
    notifyListeners();
  }

  void loadNext() {
    exploreLoader = true;
    notifyListeners();

    getExploreEpisodes(_page++);
  }

  navigateToShow(BuildContext context, Show show) {
    FocusScope.of(context).unfocus();
    navigatorKey.currentState?.pushNamed(Routes.show, arguments: show);
  }

  clearSearch(BuildContext context) {
    FocusScope.of(context).unfocus();
    searchController.clear();
    search("");
  }
}
