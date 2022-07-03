import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popcorn_companion/constants/routes.dart';
import 'package:popcorn_companion/main.dart';
import 'package:popcorn_companion/models/api/people.dart';
import 'package:popcorn_companion/providers/base_view_model.dart';
import 'package:popcorn_companion/providers/services/api_service.dart';


final explorePeopleProvider = ChangeNotifierProvider<ExplorePeopleViewModel>((ref) => ExplorePeopleViewModel(ref));

class ExplorePeopleViewModel extends BaseViewModel {

  final ChangeNotifierProviderRef ref;


  ExplorePeopleViewModel(this.ref){
    exploreLoader = true;
    getExplorePeople(_page);

    notifyListeners();
  }


  int _page = 0;


  List<People> searchPeople = [];
  bool searchLoader = false;

  List<People> explorePeople = [];
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

      final result = await ref.watch(apiProvider).searchPeople(query);
      searchPeople = result.map((e) => e.people).toList();

      searchLoader = false;
      notifyListeners();
    });
  }

  Future<void> getExplorePeople(int page) async {
    final result = await ref.watch(apiProvider).getPeopleFromIndexByPage(page);
    explorePeople.addAll(result);
    exploreLoader = false;
    notifyListeners();
  }

  void loadNext() {
    exploreLoader = true;
    notifyListeners();

    getExplorePeople(_page++);
  }

  navigateToPeople(BuildContext context, People people) {
    FocusScope.of(context).unfocus();
    navigatorKey.currentState?.pushNamed(Routes.people, arguments: people);
  }

  clearSearch(BuildContext context) {
    FocusScope.of(context).unfocus();
    searchController.clear();
    search("");
  }

}
