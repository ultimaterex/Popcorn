
import 'package:json_annotation/json_annotation.dart';
import 'package:popcorn_companion/models/api/people.dart';

part 'list_people.g.dart';

@JsonSerializable()
class ListPeople {
  double score;
  @JsonKey(name: "person") People people;

  ListPeople(this.score, this.people);

  factory ListPeople.fromJson(Map<String, dynamic> json) => _$ListPeopleFromJson(json);

  Map<String, dynamic> toJson() => _$ListPeopleToJson(this);
}

