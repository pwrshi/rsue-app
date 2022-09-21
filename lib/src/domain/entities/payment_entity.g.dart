// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PaymentEntity _$$_PaymentEntityFromJson(Map<String, dynamic> json) =>
    _$_PaymentEntity(
      name: json['name'] as String,
      url: json['url'] as String,
      dateOfReceiptFormation:
          DateTime.parse(json['dateOfReceiptFormation'] as String),
      dateOfServiceStarting:
          DateTime.parse(json['dateOfServiceStarting'] as String),
      dateOfServiceEnding:
          DateTime.parse(json['dateOfServiceEnding'] as String),
    );

Map<String, dynamic> _$$_PaymentEntityToJson(_$_PaymentEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'dateOfReceiptFormation':
          instance.dateOfReceiptFormation.toIso8601String(),
      'dateOfServiceStarting': instance.dateOfServiceStarting.toIso8601String(),
      'dateOfServiceEnding': instance.dateOfServiceEnding.toIso8601String(),
    };
