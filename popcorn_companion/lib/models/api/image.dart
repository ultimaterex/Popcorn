import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';


part 'image.g.dart';


@JsonSerializable()
@HiveType(typeId: 3)
class Image {
  @HiveField(0)String? medium;
  @HiveField(1) String? original;

  Image({this.medium, this.original});

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);

  Map<String, dynamic> toJson() => _$ImageToJson(this);
}
