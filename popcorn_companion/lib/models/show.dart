
import 'package:json_annotation/json_annotation.dart';
import 'package:popcorn_companion/models/image.dart';
import 'package:popcorn_companion/models/rating.dart';
import 'package:popcorn_companion/models/schedule.dart';

import 'externals.dart';
import 'links.dart';
import 'network.dart';


part 'show.g.dart';


@JsonSerializable()
class Show {
  int? id;
  String? url;
  String? name;
  String? type;
  String? language;
  List<String>? genres;
  String? status;
  int? runtime;
  int? averageRuntime;
  String? premiered;
  String? ended;
  String? officialSite;
  Schedule? schedule;
  Rating? rating;
  int? weight;
  Network? network;
  Externals? externals;
  Image? image;
  String? summary;
  int? updated;
  Links? lLinks;

  Show(
      {this.id,
        this.url,
        this.name,
        this.type,
        this.language,
        this.genres,
        this.status,
        this.runtime,
        this.averageRuntime,
        this.premiered,
        this.ended,
        this.officialSite,
        this.schedule,
        this.rating,
        this.weight,
        this.network,
        this.externals,
        this.image,
        this.summary,
        this.updated,
        this.lLinks});

  factory Show.fromJson(Map<String, dynamic> json) => _$ShowFromJson(json);

  Map<String, dynamic> toJson() => _$ShowToJson(this);
}

