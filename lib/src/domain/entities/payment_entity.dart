import 'package:equatable/equatable.dart';

class PaymentEntity extends Equatable {
  const PaymentEntity(
      {required this.name,
      required this.url,
      required this.dateOfReceiptFormation,
      required this.dateOfServiceEnding,
      required this.dateOfServiceStarting});
  final String name;
  final String url;
  final DateTime dateOfReceiptFormation;
  final DateTime dateOfServiceStarting;
  final DateTime dateOfServiceEnding;

  @override
  List<Object> get props => [
        name,
        url,
        dateOfReceiptFormation,
        dateOfServiceEnding,
        dateOfServiceStarting
      ];
}
