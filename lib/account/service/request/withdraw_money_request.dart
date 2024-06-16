class WithdrawMoneyRequest {
  final double amount;
  final String note;
  final String category;

  const WithdrawMoneyRequest({
    required this.amount,
    required this.note,
    required this.category
  });

  Map<String, dynamic> toJson() {
    return {
      "note": note,
      "amount": amount.toString(),
      "category": category
    };
  }
}