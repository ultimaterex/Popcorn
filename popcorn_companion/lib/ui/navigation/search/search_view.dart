import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popcorn_companion/models/list_show.dart';
import 'package:popcorn_companion/ui/navigation/search/search_view_model.dart';

final searchProvider = ChangeNotifierProvider<SearchViewModel>((ref) => SearchViewModel());

class SearchView extends ConsumerWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(searchProvider);

    return Scaffold(
      backgroundColor: Colors.black12,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 32, 16, 8),
                child: Text("Search",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
              searchBar(viewModel),
              if (!viewModel.searchMode) ...[
                Container(
                  height: 50,
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text("Categories",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white60)),
                ),
                Container(
                  height: 50,
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text("Popular Searches",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white60)),
                ),
              ] else
                viewModel.shows.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.red),
                      )
                    : Expanded(
                        child: ListView.builder(
                            itemCount: viewModel.shows.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ShowTile(viewModel, viewModel.shows[index]);
                            }),
                      ),
            ]),
      ),
      // bottomNavigationBar: navigation(),
    );
  }

  Widget ShowTile(SearchViewModel viewModel, ListShow ls) => Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: CachedNetworkImage(
              height: 150,
              width: 100,
              imageUrl: ls.show?.image?.medium ?? "",
              imageBuilder: (context, imageProvider) => Container(
                width: 80.0,
                height: 80.0,
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
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${ls.show?.name}",
                  overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: true,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(ls.show?.genres?.join(',') ?? "", style: TextStyle(color: Colors.white)),
                  const SizedBox(height: 10),
                  Text("${ls.show?.premiered?.substring(0, 4)}", style: TextStyle(color: Colors.white)),
                  Text("${ls.show?.rating?.average ?? "No Rating"}", style: TextStyle(color: Colors.white)),
                  Text("${ls.show?.runtime} min", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          )
        ],
      )
      // ListTile(
      // leading: CachedNetworkImage(
      //   // height: ,
      //   imageUrl: ls.show?.image?.medium ?? "",
      //   progressIndicatorBuilder: (context, url, downloadProgress) =>
      //       CircularProgressIndicator(value: downloadProgress.progress),
      //   errorWidget: (context, url, error) => Icon(Icons.error),
      // ),
      // trailing: const Text(
      //   "GFG",
      //   style: TextStyle(color: Colors.green, fontSize: 15),
      // ),
      // title: Text(
      //   "${ls.show?.name}",
      //   style: TextStyle(color: Colors.white),
      // )),
      );

  Widget searchBar(SearchViewModel vm) => Container(
      color: Colors.black26,
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          onChanged: (query) async => (vm.search(query)),
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.white60,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            hintText: "Search",
            hintStyle: const TextStyle(color: Colors.white60),
          ),
        ),
      ));
}
