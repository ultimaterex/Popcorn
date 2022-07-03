import 'package:json_annotation/json_annotation.dart';
import 'package:popcorn_companion/models/api/show.dart';

part 'embedded.g.dart';

@JsonSerializable()
class Embedded {
  Show? show;

  Embedded(this.show);

  factory Embedded.fromJson(Map<String, dynamic> json) => _$EmbeddedFromJson(json);

  Map<String, dynamic> toJson() => _$EmbeddedToJson(this);
}
