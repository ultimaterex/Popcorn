import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popcorn_companion/constants/routes.dart';
import 'package:popcorn_companion/main.dart';
import 'package:popcorn_companion/models/api/people.dart';
import 'package:popcorn_companion/models/api/show.dart';
import 'package:popcorn_companion/providers/base_view_model.dart';
import 'package:popcorn_companion/providers/services/api_service.dart';

final peopleProvider = ChangeNotifierProvider<PeopleViewModel>((ref) => PeopleViewModel(ref));

class PeopleViewModel extends BaseViewModel {
  final ChangeNotifierProviderRef ref;

  PeopleViewModel(this.ref) {}

  People? people;

  Future<bool> initialize(people) async {
    clear();
    this.people = people;

    notifyListeners();
    await getCastCredits();
    return true;
  }

  void clear() {
    people = null;
    shows = [];
  }

  List<Show> shows = [];

  Future getCastCredits() async {
    final result = await ref.watch(apiProvider).getCastCredits("${people?.id.toString()}");
    shows = result.where((element) => element.embedded.show != null).map((e) => e.embedded.show!).toList();
    notifyListeners();
  }

  navigateToShow(BuildContext context, Show show) {
    FocusScope.of(context).unfocus();
    navigatorKey.currentState?.pushNamed(Routes.show, arguments: show);
  }
}
