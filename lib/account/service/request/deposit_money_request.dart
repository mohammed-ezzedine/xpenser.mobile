class DepositMoneyRequest {
  final String note;
  final double amount;

  const DepositMoneyRequest({
    required this.note,
    required this.amount
  });

  Map<String, dynamic> toJson() {
    return {
      "note": note,
      "amount": amount.toString()
    };
  }
}