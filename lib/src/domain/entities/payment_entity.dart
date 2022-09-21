import 'package:freezed_annotation/freezed_annotation.dart';
part 'payment_entity.freezed.dart';
part 'payment_entity.g.dart';

@freezed
class PaymentEntity with _$PaymentEntity {
  const factory PaymentEntity(
      {required String name,
      required String url,
      required DateTime dateOfReceiptFormation,
      required DateTime dateOfServiceStarting,
      required DateTime dateOfServiceEnding}) = _PaymentEntity;

  factory PaymentEntity.fromJson(Map<String, Object?> json) =>
      _$PaymentEntityFromJson(json);
}
