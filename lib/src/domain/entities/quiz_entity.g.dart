// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Quiz _$$_QuizFromJson(Map<String, dynamic> json) => _$_Quiz(
      name: json['name'] as String,
      dateTime: json['dateTime'] as String?,
      rooms: json['rooms'] as String?,
      teachers: json['teachers'] as String?,
      type: $enumDecodeNullable(_$SessionTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$$_QuizToJson(_$_Quiz instance) => <String, dynamic>{
      'name': instance.name,
      'dateTime': instance.dateTime,
      'rooms': instance.rooms,
      'teachers': instance.teachers,
      'type': _$SessionTypeEnumMap[instance.type],
    };

const _$SessionTypeEnumMap = {
  SessionType.exam: 'exam',
  SessionType.practice: 'practice',
  SessionType.credit: 'credit',
};
