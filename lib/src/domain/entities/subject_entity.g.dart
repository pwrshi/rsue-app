// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'subject_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SubjectEntity _$$_SubjectEntityFromJson(Map<String, dynamic> json) =>
    _$_SubjectEntity(
      name: json['name'] as String,
      teachersname: json['teachersname'] as String,
      type: $enumDecode(_$SessionTypeEnumMap, json['type']),
      isClosed: json['isClosed'] as bool,
      statement: json['statement'] as int,
      controlPoints: (json['controlPoints'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
    );

Map<String, dynamic> _$$_SubjectEntityToJson(_$_SubjectEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'teachersname': instance.teachersname,
      'type': _$SessionTypeEnumMap[instance.type]!,
      'isClosed': instance.isClosed,
      'statement': instance.statement,
      'controlPoints': instance.controlPoints,
    };

const _$SessionTypeEnumMap = {
  SessionType.exam: 'exam',
  SessionType.credit: 'credit',
  SessionType.practice: 'practice',
};
