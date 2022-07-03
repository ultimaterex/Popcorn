

import 'package:json_annotation/json_annotation.dart';

import 'embedded.dart';

part 'cast_credit.g.dart';


@JsonSerializable()
class CastCredit {
  bool? self;
  bool? voice;
  @JsonKey(name: "_embedded") Embedded embedded;


  CastCredit(this.self, this.voice, this.embedded);

  factory CastCredit.fromJson(Map<String, dynamic> json) => _$CastCreditFromJson(json);

  Map<String, dynamic> toJson() => _$CastCreditToJson(this);
}
