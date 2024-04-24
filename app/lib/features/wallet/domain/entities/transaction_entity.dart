class TransactionEntity {
  final int id;
  final String type;
  final String amount;
  final String? description;
  final String createdAt;

  TransactionEntity({
    required this.id,
    required this.type,
    required this.amount,
    required this.description,
    required this.createdAt,
  });
}
