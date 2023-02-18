// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AbstractLesson _$$_AbstractLessonFromJson(Map<String, dynamic> json) =>
    _$_AbstractLesson(
      name: json['name'] as String,
      teachersname: json['teachersname'] as String,
      room: json['room'] as String,
      type: $enumDecode(_$LessonTypeEnumMap, json['type']),
      time: json['time'] as String,
      subgroup: json['subgroup'] as String?,
    );

Map<String, dynamic> _$$_AbstractLessonToJson(_$_AbstractLesson instance) =>
    <String, dynamic>{
      'name': instance.name,
      'teachersname': instance.teachersname,
      'room': instance.room,
      'type': _$LessonTypeEnumMap[instance.type]!,
      'time': instance.time,
      'subgroup': instance.subgroup,
    };

const _$LessonTypeEnumMap = {
  LessonType.lab: 'lab',
  LessonType.lection: 'lection',
  LessonType.practice: 'practice',
};

_$_ConcreteLesson _$$_ConcreteLessonFromJson(Map<String, dynamic> json) =>
    _$_ConcreteLesson(
      name: json['name'] as String,
      teachersname: json['teachersname'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      room: json['room'] as String,
      type: $enumDecode(_$LessonTypeEnumMap, json['type']),
      subgroup: json['subgroup'] as String?,
    );

Map<String, dynamic> _$$_ConcreteLessonToJson(_$_ConcreteLesson instance) =>
    <String, dynamic>{
      'name': instance.name,
      'teachersname': instance.teachersname,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'room': instance.room,
      'type': _$LessonTypeEnumMap[instance.type]!,
      'subgroup': instance.subgroup,
    };
