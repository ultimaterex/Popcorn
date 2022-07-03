import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:popcorn_companion/constants/strings.dart';
import 'package:popcorn_companion/models/api/episode.dart';

class EpisodeCard extends StatelessWidget {
  const EpisodeCard({Key? key, required this.episode}) : super(key: key);

  final Episode episode;
  // final VoidCallback? onTapped;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
      decoration: BoxDecoration(color: theme.colorScheme.tertiary, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            flex: 5,
            child: CachedNetworkImage(
              imageUrl: episode.image?.medium ?? "",
              imageBuilder: (context, imageProvider) => Stack(children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                    image: DecorationImage(image: imageProvider, fit: BoxFit.cover, alignment: Alignment.center),
                  ),
                ),
              ]),
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
              errorWidget: (context, url, error) => SizedBox(
                  height: 150,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(Icons.error, color: theme.primaryColor),
                  )),
            ),
          ),
          Flexible(
              flex: 3,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "${episode.embedded?.show?.name ?? Strings.titleUnavailable}\nS${episode.season} E${episode.number} ${episode.name}",
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
