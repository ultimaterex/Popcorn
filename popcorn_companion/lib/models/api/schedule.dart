import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';


part 'schedule.g.dart';


@JsonSerializable()
@HiveType(typeId: 2)
class Schedule {
  @HiveField(0) String time;
  @HiveField(1) List<String> days;

  Schedule({required this.time, required this.days});

  factory Schedule.fromJson(Map<String, dynamic> json) => _$ScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleToJson(this);
}
