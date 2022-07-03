import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popcorn_companion/constants/strings.dart';
import 'package:popcorn_companion/models/api/show.dart';
import 'package:popcorn_companion/ui/shows/shows_view_model.dart';
import 'package:popcorn_companion/ui/widgets/toolbar_button.dart';
import 'package:popcorn_companion/ui/widgets/episode_tile.dart';
import 'package:popcorn_companion/utilities/extensions.dart';
import 'package:popcorn_companion/utilities/mixins.dart';

class ShowsView extends ConsumerStatefulWidget {
  const ShowsView({Key? key}) : super(key: key);

  @override
  ShowsViewState createState() => ShowsViewState();
}

class ShowsViewState extends ConsumerState<ShowsView> with PostFrameMixin {
  Future<bool>? _future;

  @override
  void initState() {
    super.initState();
    postFrame(() async =>
        {_future = ref.read(showProvider).initialize(ModalRoute.of(context)?.settings.arguments as Show)});
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(showProvider);
    final theme = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 100,
        leading: ToolbarButton(
          button: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        actions: [
          ToolbarButton(
              button: IconButton(
                  icon: Icon((viewModel.favourited ? Icons.bookmark : Icons.bookmark_border)),
                  onPressed: () => viewModel.toggleFavouriteShow())),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            CachedNetworkImage(
              imageUrl: viewModel.show?.image?.original ?? "",
              imageBuilder: (context, imageProvider) => ShaderMask(
                shaderCallback: (rect) {
                  return const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Colors.transparent],
                  ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                },
                blendMode: BlendMode.dstIn,
                child: Container(
                  height: 400.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: imageProvider, fit: BoxFit.fitWidth, alignment: Alignment.topCenter),
                  ),
                ),
              ),
              progressIndicatorBuilder: (context, url, downloadProgress) => SizedBox(
                height: 400.0,
                child: Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
              ),
              errorWidget: (context, url, error) =>
                  SizedBox(height: 400, child: Icon(Icons.error, color: theme.primaryColor)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text("${viewModel.show?.name}",
                  maxLines: 2, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: theme.primaryColor)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 12),
              child: Text("${viewModel.show?.genres?.join(", ")}",
                  maxLines: 2, style: TextStyle(color: theme.primaryColor.withOpacity(0.8))),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(12, 12, 48, 12),
              child: Text(
                viewModel.show?.summary != null
                    ? "${viewModel.show?.summary?.stripHtml()}"
                    : Strings.descriptionUnavailable,
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(12, 12, 48, 12),
              child: viewModel.show?.schedule.time == "" && (viewModel.show?.schedule.days.isEmpty ?? true)
                  ? const Text(Strings.scheduleUnavailable)
                  : RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                          text: "${Strings.schedule}: ",
                          style: TextStyle(color: theme.primaryColor),
                        ),
                        TextSpan(
                            text: "${viewModel.show?.schedule.time} ${viewModel.show?.schedule.days.join(", ")}",
                            style: TextStyle(fontWeight: FontWeight.bold, color: theme.primaryColor))
                      ]),
                    ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Divider(
                  color: theme.primaryColor.withOpacity(0.7),
                  thickness: 1,
                )),
            FutureBuilder(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(12),
                    child: SizedBox(
                      height: 500,
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.builder(
                            itemCount: viewModel.episodes.length,
                            itemBuilder: (BuildContext context, int index) {
                              return EpisodeTile(episode: viewModel.episodes[index]);
                            }),
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
