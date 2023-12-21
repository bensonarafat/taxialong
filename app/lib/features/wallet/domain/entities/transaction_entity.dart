class TransactionEntity {
  final bool status;
  final String message;
  final int id;
  final String type;
  final String amount;
  final String? description;

  TransactionEntity({
    required this.status,
    required this.message,
    required this.id,
    required this.type,
    required this.amount,
    required this.description,
  });
}
