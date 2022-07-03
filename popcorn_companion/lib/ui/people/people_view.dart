import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popcorn_companion/constants/strings.dart';
import 'package:popcorn_companion/models/api/people.dart';
import 'package:popcorn_companion/ui/people/people_view_model.dart';
import 'package:popcorn_companion/ui/widgets/show_tile.dart';
import 'package:popcorn_companion/ui/widgets/toolbar_button.dart';
import 'package:popcorn_companion/utilities/mixins.dart';


class PeopleView extends ConsumerStatefulWidget {
  const PeopleView({Key? key}) : super(key: key);

  @override
  PeopleViewState createState() => PeopleViewState();
}

class PeopleViewState extends ConsumerState<PeopleView> with PostFrameMixin {
  Future<bool>? _future;

  @override
  void initState() {
    super.initState();
    postFrame(() async =>
        {_future = ref.read(peopleProvider).initialize(ModalRoute.of(context)?.settings.arguments as People)});
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(peopleProvider);
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
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            CachedNetworkImage(
              imageUrl: viewModel.people?.image?.original ?? "",
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
              child: Text("${viewModel.people?.name}",
                  maxLines: 2, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: theme.primaryColor)),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 12, top: 12),
              child: Text("${viewModel.people?.gender}",
                  maxLines: 2, style: TextStyle(color: theme.primaryColor.withOpacity(0.8))),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(12, 12, 48, 12),
              child: Text(
                viewModel.people?.birthday != null
                    ? "${viewModel.people?.birthday}"
                    : Strings.descriptionUnavailable,
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
                            itemCount: viewModel.shows.length,
                            itemBuilder: (BuildContext context, int index) {
                              final show = viewModel.shows[index];
                              return ShowTile(show: show, onTapped: () => viewModel.navigateToShow(context, show),);
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
