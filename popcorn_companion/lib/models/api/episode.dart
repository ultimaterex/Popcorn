import 'package:json_annotation/json_annotation.dart';
import 'package:popcorn_companion/models/api/embedded.dart';
import 'package:popcorn_companion/models/api/image.dart';
import 'package:popcorn_companion/models/api/rating.dart';

import 'links.dart';

part 'episode.g.dart';

@JsonSerializable()
class Episode {
  int? id;
  String? url;
  String? name;
  int? season;
  int? number;
  String? type;
  String? airdate;
  String? airtime;
  String? airstamp;
  int? runtime;
  Rating? rating;
  Image? image;
  String? summary;
  Links? lLinks;
  @JsonKey(name: "_embedded")
  Embedded? embedded;

  Episode(this.id, this.url, this.name, this.season, this.number, this.type, this.airdate, this.airtime, this.airstamp,
      this.runtime, this.rating, this.image, this.summary, this.lLinks, this.embedded);

  factory Episode.fromJson(Map<String, dynamic> json) => _$EpisodeFromJson(json);

  Map<String, dynamic> toJson() => _$EpisodeToJson(this);
}
