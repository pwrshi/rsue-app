// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subject _$SubjectFromJson(Map<String, dynamic> json) => Subject(
      Map<String, String>.from(json['raw'] as Map),
    )
      ..subgroup = json['subgroup'] as String
      ..numberOfLesson = json['numberOfLesson'] as int
      ..name = json['name'] as String
      ..teacher = json['teacher'] as String
      ..time = json['time'] as String
      ..room = json['room'] as String
      ..type = json['type'] as String;

Map<String, dynamic> _$SubjectToJson(Subject instance) => <String, dynamic>{
      'raw': instance.raw,
      'subgroup': instance.subgroup,
      'numberOfLesson': instance.numberOfLesson,
      'name': instance.name,
      'teacher': instance.teacher,
      'time': instance.time,
      'room': instance.room,
      'type': instance.type,
    };

Day _$DayFromJson(Map<String, dynamic> json) => Day(
      json['weekdayName'] as String,
      (json['raw'] as List<dynamic>)
          .map((e) => Map<String, String>.from(e as Map))
          .toList(),
    )
      ..ofWeek = json['ofWeek'] as int
      ..subjects = (json['subjects'] as List<dynamic>)
          .map((e) => Subject.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$DayToJson(Day instance) => <String, dynamic>{
      'weekdayName': instance.weekdayName,
      'ofWeek': instance.ofWeek,
      'subjects': instance.subjects,
      'raw': instance.raw,
    };

Schedule _$ScheduleFromJson(Map<String, dynamic> json) => Schedule(
      (json['raw'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k,
            (e as Map<String, dynamic>).map(
              (k, e) => MapEntry(
                  k,
                  (e as List<dynamic>)
                      .map((e) => Map<String, String>.from(e as Map))
                      .toList()),
            )),
      ),
      faculty: json['faculty'] as int,
      course: json['course'] as int,
      group: json['group'] as int,
    )
      ..schedule = (json['schedule'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k,
            (e as Map<String, dynamic>).map(
              (k, e) => MapEntry(
                  int.parse(k), Day.fromJson(e as Map<String, dynamic>)),
            )),
      )
      ..createDate = DateTime.parse(json['createDate'] as String);

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
      'raw': instance.raw,
      'schedule': instance.schedule.map(
          (k, e) => MapEntry(k, e.map((k, e) => MapEntry(k.toString(), e)))),
      'createDate': instance.createDate.toIso8601String(),
      'faculty': instance.faculty,
      'course': instance.course,
      'group': instance.group,
    };
