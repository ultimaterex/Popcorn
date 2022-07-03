import 'package:json_annotation/json_annotation.dart';



part 'network.g.dart';


@JsonSerializable()
class Network {
  int? id;
  String? name;
  // Country? country;
  String? officialSite;

  Network({this.id, this.name, this.officialSite});
  // Network({this.id, this.name, this.country, this.officialSite});

  factory Network.fromJson(Map<String, dynamic> json) => _$NetworkFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkToJson(this);

}
