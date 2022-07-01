import 'package:json_annotation/json_annotation.dart';
import 'package:popcorn_companion/models/self.dart';


part 'links.g.dart';


@JsonSerializable()
class Links {
  Self? self;
  Self? previousepisode;

  Links({this.self, this.previousepisode});

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);

  Map<String, dynamic> toJson() => _$LinksToJson(this);
}
