import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popcorn_companion/constants/strings.dart';
import 'package:popcorn_companion/ui/widgets/schedule_carousel.dart';
import 'package:popcorn_companion/utilities/mixins.dart';

import 'home_view_model.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> with PostFrameMixin {
  Future<bool>? _futureLocal;
  Future<bool>? _futureGlobal;
  Future<bool>? _futureMissed;

  @override
  void initState() {
    super.initState();
    postFrame(() async {
      final viewModel = ref.read(homeProvider);
      await viewModel.initialize();
      _futureLocal = viewModel.getLocalAiringShows();
      _futureGlobal = viewModel.getGlobalAiringShows();
      _futureMissed = viewModel.getMissedGlobalAiringShows();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(homeProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 8),
                child: Text(Strings.schedule,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              ),
              ScheduleCarousel(
                  title: Strings.airingLocally,
                  future: _futureLocal,
                  episodes: viewModel.episodesLocal,
                  onTapped: (show) => viewModel.navigateToShow(context, show)),
              ScheduleCarousel(
                  title: Strings.airingGlobally,
                  future: _futureGlobal,
                  episodes: viewModel.episodesGlobal,
                  onTapped: (show) => viewModel.navigateToShow(context, show)),
              ScheduleCarousel(
                  title: Strings.airingPreviously,
                  future: _futureMissed,
                  episodes: viewModel.episodesMissed,
                  onTapped: (show) => viewModel.navigateToShow(context, show)),
            ]),
      ),
      // bottomNavigationBar: navigation(viewModel),
    );
  }
}
