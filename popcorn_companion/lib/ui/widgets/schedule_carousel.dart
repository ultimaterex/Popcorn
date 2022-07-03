import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:popcorn_companion/models/api/episode.dart';
import 'package:popcorn_companion/models/api/show.dart';
import 'package:popcorn_companion/ui/widgets/episode_card.dart';

class ScheduleCarousel extends StatelessWidget {
  const ScheduleCarousel({
    Key? key,
    required this.title,
    required this.future,
    required this.episodes,
    required this.onTapped,
  }) : super(key: key);

  final String title;
  final Future<bool>? future;
  final List<Episode> episodes;
  final Function(Show show) onTapped;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child:
            Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      FutureBuilder(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CarouselSlider(
                options: CarouselOptions(height: 150),
                items: episodes.map((episode) {
                  return Builder(
                    builder: (BuildContext context) {
                      final Show? show = episode.embedded?.show;
                      return InkWell(
                        onTap: () => show != null ? onTapped(show) : null,
                        child: EpisodeCard(
                          episode: episode,
                        ),
                      );
                    },
                  );
                }).toList(),
              );
            } else if (snapshot.hasError) {
              return const SizedBox(
                  height: 150,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Icon(Icons.error),
                  ));
            } else {
              return const SizedBox(
                height: 150,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                ),
              );
            }
          }),
    ]);
  }
}
