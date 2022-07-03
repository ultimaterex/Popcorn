import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:popcorn_companion/constants/strings.dart';
import 'package:popcorn_companion/models/api/episode.dart';
import 'package:popcorn_companion/utilities/extensions.dart';

class EpisodeTile extends StatelessWidget {
  const EpisodeTile({Key? key, required this.episode}) : super(key: key);

  final Episode episode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(mainAxisSize: MainAxisSize.min, children: [
      if (episode.number == 1)
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text("${Strings.season} ${episode.season}",
                textAlign: TextAlign.start,
                style: TextStyle(color: theme.primaryColor, fontSize: 18, fontWeight: FontWeight.bold))),
      Container(
          padding: const EdgeInsets.all(8),
          child: InkWell(
            // onTap: () => viewModel.navigateToEpisode(episode),
            onTap: () => openEpisodeSheet(context, episode),
            child: Row(
              children: [
                Flexible(
                  flex: 2,
                  child: Row(
                    children: [
                      if (episode.image?.medium != "")
                        Flexible(
                          child: CachedNetworkImage(
                            imageUrl: episode.image?.medium ?? "",
                            imageBuilder: (context, imageProvider) => Container(
                              height: 60.0,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover, alignment: Alignment.center),
                              ),
                            ),
                            progressIndicatorBuilder: (context, url, downloadProgress) => SizedBox(
                              height: 60.0,
                              width: 100,
                              child: Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                            ),
                            errorWidget: (context, url, error) =>
                                SizedBox(height: 60, width: 100, child: Icon(Icons.error, color: theme.primaryColor)),
                          ),
                        ),
                      Flexible(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${episode.name}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: theme.primaryColor, fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "S${episode.season} E${episode.number} | ${episode.runtime}${Strings.minutesShorthand}",
                                style: TextStyle(
                                    color: theme.primaryColor.withOpacity(0.7),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    ]);
  }

  openEpisodeSheet(BuildContext context, Episode episode) {
    final theme = Theme.of(context);
    return showModalBottomSheet<dynamic>(
        backgroundColor: theme.backgroundColor,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Wrap(children: [
            CachedNetworkImage(
              imageUrl: episode.image?.original ?? "",
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
                  height: 200.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: imageProvider, fit: BoxFit.fitWidth, alignment: Alignment.topCenter),
                  ),
                ),
              ),
              progressIndicatorBuilder: (context, url, downloadProgress) => SizedBox(
                height: 200.0,
                child: Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
              ),
              errorWidget: (context, url, error) =>
                  SizedBox(height: 200, width: double.infinity, child: Icon(Icons.error, color: theme.primaryColor)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text("${episode.name}",
                  maxLines: 2, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: theme.primaryColor)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 12),
              child: Text("S${episode.season} E${episode.number} | ${episode.runtime}${Strings.minutesShorthand}",
                  style: TextStyle(color: theme.primaryColor.withOpacity(0.8))),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(12, 12, 48, 100),
              child: Text(
                episode.summary != null ? "${episode.summary?.stripHtml()}" : Strings.descriptionUnavailable,
                style: TextStyle(color: theme.primaryColor),
              ),
            ),
          ]);
        });
  }
}
