import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popcorn_companion/constants/strings.dart';
import 'package:popcorn_companion/ui/navigation/explore_shows/explore_shows_view_model.dart';
import 'package:popcorn_companion/ui/widgets/search_bar.dart';
import 'package:popcorn_companion/ui/widgets/show_tile.dart';
import 'package:popcorn_companion/utilities/mixins.dart';

class ExploreShowsView extends ConsumerStatefulWidget {
  const ExploreShowsView({Key? key}) : super(key: key);

  @override
  ExploreShowsViewState createState() => ExploreShowsViewState();
}

class ExploreShowsViewState extends ConsumerState<ExploreShowsView> with PostFrameMixin {
  @override
  void initState() {
    super.initState();

    postFrame(() {
      // Add listener for pagination in listview
      final scrollController = ref.watch(exploreShowsProvider).scrollController;
      scrollController.addListener(() {
        if (scrollController.position.atEdge) {
          bool atBottom = !(scrollController.position.pixels == 0);
          if (atBottom) ref.read(exploreShowsProvider).loadNext();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(exploreShowsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 8),
                child: Text(
                  Strings.exploreShows,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              SearchBar(
                onChanged: (query) => viewModel.search(query),
                onClear: () => viewModel.clearSearch(context),
                controller: viewModel.searchController,
              ),
              if (!viewModel.searchMode)
                ...popular(viewModel)
              else
                viewModel.searchLoader
                    ? const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Expanded(
                        child: viewModel.searchShows.isEmpty
                            ? Center(
                                child: Text(
                                Strings.noResultsFound,
                                textAlign: TextAlign.center,
                                style: theme.textTheme.bodyLarge,
                              ))
                            : ListView.builder(
                                itemCount: viewModel.searchShows.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final show = viewModel.searchShows[index];
                                  return ShowTile(show: show, onTapped: () => viewModel.navigateToShow(context, show));
                                }),
                      ),
            ]),
      ),
      // bottomNavigationBar: navigation(),
    );
  }

  List<Widget> popular(ExploreShowsViewModel vm) {
    final theme = Theme.of(context);
    return [
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
        child: Text(
          Strings.explore,
          // style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white60)
          style: theme.textTheme.titleMedium,
        ),
      ),
      Expanded(
        child: Stack(children: [
          ListView.builder(
              controller: vm.scrollController,
              itemCount: vm.exploreShows.length,
              itemBuilder: (BuildContext context, int index) {
                final show = vm.exploreShows[index];
                return ShowTile(show: show, onTapped: () => vm.navigateToShow(context, show));
              }),
          if (vm.exploreLoader) const Center(child: CircularProgressIndicator())
        ]),
      )
    ];
  }
}
