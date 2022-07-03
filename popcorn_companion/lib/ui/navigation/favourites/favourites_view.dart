import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popcorn_companion/constants/strings.dart';
import 'package:popcorn_companion/ui/widgets/show_tile.dart';
import 'package:popcorn_companion/utilities/mixins.dart';

import 'favourites_view_model.dart';

class FavouritesView extends ConsumerStatefulWidget {
  const FavouritesView({Key? key}) : super(key: key);

  @override
  FavouritesViewState createState() => FavouritesViewState();
}

class FavouritesViewState extends ConsumerState<FavouritesView> with PostFrameMixin {
  @override
  void initState() {
    super.initState();
    postFrame(() {
      ref.read(favouritesProvider).initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(favouritesProvider);
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
                  Strings.favourites,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              viewModel.favourites.isEmpty
                  ? Center(
                      child: Text(
                      Strings.noFavourites,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge,
                    ))
                  : Expanded(
                      child: ListView.builder(
                          itemCount: viewModel.favourites.length,
                          itemBuilder: (BuildContext context, int index) {
                            final show = viewModel.favourites[index];
                            return ShowTile(show: show, onTapped: () => viewModel.navigateToShow(context, show));
                          }),
                    ),
            ]),
      ),
      // bottomNavigationBar: navigation(),
    );
  }
}
