// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleService _$ScheduleServiceFromJson(Map<String, dynamic> json) =>
    ScheduleService(
      (json['evenWeek'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            int.parse(k),
            (e as List<dynamic>)
                .map((e) => AbstractLesson.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
      (json['oddWeek'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            int.parse(k),
            (e as List<dynamic>)
                .map((e) => AbstractLesson.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
    );

Map<String, dynamic> _$ScheduleServiceToJson(ScheduleService instance) =>
    <String, dynamic>{
      'evenWeek': instance.evenWeek.map((k, e) => MapEntry(k.toString(), e)),
      'oddWeek': instance.oddWeek.map((k, e) => MapEntry(k.toString(), e)),
    };
