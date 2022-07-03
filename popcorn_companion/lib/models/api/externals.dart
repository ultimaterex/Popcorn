import 'package:json_annotation/json_annotation.dart';


part 'externals.g.dart';


@JsonSerializable()
class Externals {
  int? tvrage;
  int? thetvdb;
  String? imdb;

  Externals({this.tvrage, this.thetvdb, this.imdb});

  factory Externals.fromJson(Map<String, dynamic> json) => _$ExternalsFromJson(json);

  Map<String, dynamic> toJson() => _$ExternalsToJson(this);
}

