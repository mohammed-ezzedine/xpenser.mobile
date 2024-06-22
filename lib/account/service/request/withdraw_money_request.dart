class WithdrawMoneyRequest {
  final double amount;
  final String note;
  final String category;
  DateTime? timestamp;

  WithdrawMoneyRequest({
    required this.amount,
    required this.note,
    required this.category,
    this.timestamp
  });

  Map<String, dynamic> toJson() {
    return {
      "note": note,
      "amount": amount.toString(),
      "category": category,
      "timestamp": timestamp?.toIso8601String()
    };
  }
}