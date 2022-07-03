import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popcorn_companion/constants/routes.dart';
import 'package:popcorn_companion/main.dart';
import 'package:popcorn_companion/models/api/episode.dart';
import 'package:popcorn_companion/models/api/show.dart';
import 'package:popcorn_companion/providers/base_view_model.dart';

import '../../../providers/services/api_service.dart';

final homeProvider = ChangeNotifierProvider<HomeViewModel>((ref) => HomeViewModel(ref));

class HomeViewModel extends BaseViewModel {
  final ChangeNotifierProviderRef ref;

  HomeViewModel(this.ref);

  int currentIndex = 0;

  String country = "";

  Future<bool> initialize() async {
    country = WidgetsBinding.instance.window.locale.countryCode ?? "US"; // defaults to US
    return true;
  }

  List<Episode> episodesLocal = [];
  List<Episode> episodesGlobal = [];
  List<Episode> episodesMissed = [];

  Future<bool> getLocalAiringShows() async {
    final result = await ref.watch(apiProvider).getLocalShowsBySchedule(DateTime.now(), country);

    // Remove Episodes without images for presentation
    // episodesLocal = result.where((element) => element.image != null).toList();
    episodesLocal = result;

    // Sort Episodes to prefer ones with images for presentation
    episodesLocal.sort((a, b) => a.image != null ? 0 : 1);

    notifyListeners();
    return true;
  }

  Future<bool> getGlobalAiringShows() async {
    final result = await ref.watch(apiProvider).getWebShowsBySchedule(DateTime.now());

    // Remove Episodes without images for presentation
    // episodesGlobal = result.where((element) => element.image != null).toList();
    episodesGlobal = result;

    // Sort Episodes to prefer ones with images for presentation
    episodesGlobal.sort((a, b) => a.image != null ? 0 : 1);

    notifyListeners();
    return true;
  }

  Future<bool> getMissedGlobalAiringShows() async {
    final day = DateTime.now().subtract(const Duration(days: 1));
    final result = await ref.watch(apiProvider).getWebShowsBySchedule(day);

    // Remove Episodes without images for presentation
    // episodesMissed = result.where((element) => element.image != null).toList();
    episodesMissed = result;

    // Sort Episodes to prefer ones with images for presentation
    episodesMissed.sort((a, b) => a.image != null ? 0 : 1);

    notifyListeners();
    return true;
  }


  navigateToShow(BuildContext context, Show show) {
    FocusScope.of(context).unfocus();
    navigatorKey.currentState?.pushNamed(Routes.show, arguments: show);
  }


}
