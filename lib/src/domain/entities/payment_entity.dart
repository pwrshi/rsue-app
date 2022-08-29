class PaymentEntity {
  PaymentEntity(
      {required this.name,
      required this.url,
      required this.dateOfReceiptFormation,
      required this.dateOfServiceEnding,
      required this.dateOfServiceStarting});
  String name;
  String url;
  DateTime dateOfReceiptFormation;
  DateTime dateOfServiceStarting;
  DateTime dateOfServiceEnding;
}
