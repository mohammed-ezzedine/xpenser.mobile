class DepositMoneyRequest {
  final String note;
  final double amount;
  DateTime? timestamp;

  DepositMoneyRequest({
    required this.note,
    required this.amount,
    this.timestamp
  });

  Map<String, dynamic> toJson() {
    return {
      "note": note,
      "amount": amount.toString(),
      "timestamp": timestamp?.toIso8601String()
    };
  }
}