class TransferMoneyRequest {
  final String destinationAccountId;
  final double amount;
  DateTime? timestamp;

  TransferMoneyRequest({
    required this.destinationAccountId,
    required this.amount,
    this.timestamp
  });

  Map<String, dynamic> toJson() {
    return {
      "destinationAccountId": destinationAccountId,
      "amount": amount,
      "timestamp": timestamp?.toIso8601String()
    };
  }
}