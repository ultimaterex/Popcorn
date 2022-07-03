import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popcorn_companion/constants/strings.dart';
import 'package:popcorn_companion/models/api/people.dart';
import 'package:popcorn_companion/ui/navigation/explore_people/explore_people_view_model.dart';
import 'package:popcorn_companion/ui/widgets/rounded_info_component.dart';
import 'package:popcorn_companion/ui/widgets/search_bar.dart';
import 'package:popcorn_companion/utilities/mixins.dart';

class ExplorePeopleView extends ConsumerStatefulWidget {
  const ExplorePeopleView({Key? key}) : super(key: key);

  @override
  ExplorePeopleViewState createState() => ExplorePeopleViewState();
}

class ExplorePeopleViewState extends ConsumerState<ExplorePeopleView> with PostFrameMixin {
  @override
  void initState() {
    super.initState();
    postFrame(() {
      // Add listener for pagination in listview
      final scrollController = ref.watch(explorePeopleProvider).scrollController;
      scrollController.addListener(() {
        if (scrollController.position.atEdge) {
          bool atBottom = !(scrollController.position.pixels == 0);
          if (atBottom) ref.read(explorePeopleProvider).loadNext();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(explorePeopleProvider);
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
                  Strings.explorePeople,
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
                        child: viewModel.searchPeople.isEmpty
                            ? Center(
                                child: Text(
                                Strings.noResultsFound,
                                textAlign: TextAlign.center,
                                style: theme.textTheme.bodyLarge,
                              ))
                            : ListView.builder(
                                itemCount: viewModel.searchPeople.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final people = viewModel.searchPeople[index];
                                  return PeopleTile(people: people, onTapped: () => viewModel.navigateToPeople(context, people));
                                }),
                      ),
            ]),
      ),
      // bottomNavigationBar: navigation(),
    );
  }


List<Widget> popular(ExplorePeopleViewModel vm) {
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
            itemCount: vm.explorePeople.length,
            itemBuilder: (BuildContext context, int index) {
              final people = vm.explorePeople[index];
              // return PeopleTile(show: show, onTapped: () => vm.navigateToShow(context, show));
              return PeopleTile(people: people, onTapped: () => vm.navigateToPeople(context, people));
            }),
        if (vm.exploreLoader) const Center(child: CircularProgressIndicator())
      ]),
    )
  ];
}
}

class PeopleTile extends StatelessWidget {
  const PeopleTile({
    Key? key,
    required this.people,
    this.onTapped,
  }) : super(key: key);

  final People people;
  final VoidCallback? onTapped;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        child: InkWell(
          onTap: onTapped,
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: CachedNetworkImage(
                  height: 150,
                  width: 100,
                  imageUrl: people.image?.medium ?? "",
                  imageBuilder: (context, imageProvider) => Container(
                    height: 150,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  progressIndicatorBuilder: (context, url, downloadProgress) => SizedBox(
                    height: 150,
                    width: 100,
                    child: Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error, color: Theme.of(context).colorScheme.error),
                ),
              ),
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        people.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: true,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(people.gender ?? "", style: Theme.of(context).textTheme.labelMedium),
                      const SizedBox(height: 10),
                      if (people.birthday != null)
                        RoundedInfoComponent(
                          text: "${people.birthday}",
                          icon: const Icon(
                            Icons.cake,
                            size: 16,
                          ),
                        ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

