import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:popcorn_companion/models/api/image.dart';
import 'package:popcorn_companion/models/api/schedule.dart';

part 'show.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class Show extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String url;
  @HiveField(2)
  String name;
  @HiveField(3)
  String type;
  @HiveField(4)
  String? language;
  @HiveField(5)
  List<String>? genres;
  @HiveField(6)
  String? status;
  @HiveField(7)
  int? runtime;
  @HiveField(9)
  int? averageRuntime;
  @HiveField(10)
  String? premiered;
  @HiveField(11)
  String? ended;
  @HiveField(12)
  Schedule schedule;
  @HiveField(13)
  int weight;
  @HiveField(14)
  Image? image;
  @HiveField(15)
  String? summary;

  // String? officialSite;
  // Rating rating;
  // Network? network;
  // Externals? externals;
  // int? updated;
  // Links? lLinks;

  Show(
    this.id,
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
    this.schedule,
    this.weight,
    this.image,
    this.summary,
  );

  factory Show.fromJson(Map<String, dynamic> json) => _$ShowFromJson(json);

  Map<String, dynamic> toJson() => _$ShowToJson(this);

  @override
  String toString() {
    return "$id | $name | $url";
  }
}
