import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:popcorn_companion/constants/strings.dart';
import 'package:popcorn_companion/models/api/show.dart';
import 'package:popcorn_companion/ui/widgets/rounded_info_component.dart';

class ShowTile extends StatelessWidget {
  const ShowTile({
    Key? key,
    required this.show,
    this.onTapped,
  }) : super(key: key);

  final Show show;
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
                  imageUrl: show.image?.medium ?? "",
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
                        show.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: true,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(show.genres?.join(', ') ?? "", style: Theme.of(context).textTheme.labelMedium),
                      const SizedBox(height: 10),
                      if (show.premiered != null) RoundedInfoComponent(text: "${show.premiered?.substring(0, 4)}"),
                      const SizedBox(height: 10),
                      if (show.runtime != null)
                        RoundedInfoComponent(
                          text: "${show.runtime} ${Strings.minutesShorthand}",
                          icon: const Icon(
                            Icons.timelapse,
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
