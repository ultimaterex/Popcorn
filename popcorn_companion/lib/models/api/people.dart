
import 'package:json_annotation/json_annotation.dart';

import 'image.dart';

part 'people.g.dart';

@JsonSerializable()
class People {
  int id;
  String? url;
  String name;
  String? birthday;
  String? deathday;
  String? gender;
  Image? image;

  People(this.id, this.url, this.name, this.birthday, this.deathday, this.gender, this.image);


  factory People.fromJson(Map<String, dynamic> json) => _$PeopleFromJson(json);

  Map<String, dynamic> toJson() => _$PeopleToJson(this);
}