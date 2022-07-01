
import 'package:json_annotation/json_annotation.dart';
import 'package:popcorn_companion/models/show.dart';


part 'list_show.g.dart';


@JsonSerializable()
class ListShow {
  double? score;
  Show? show;

  ListShow({this.score, this.show});

  factory ListShow.fromJson(Map<String, dynamic> json) => _$ListShowFromJson(json);

  Map<String, dynamic> toJson() => _$ListShowToJson(this);
}

