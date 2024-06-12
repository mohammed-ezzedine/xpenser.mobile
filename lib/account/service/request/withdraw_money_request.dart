class WithdrawMoneyRequest {
  final double amount;
  final String note;

  const WithdrawMoneyRequest({
    required this.amount,
    required this.note
  });

  Map<String, dynamic> toJson() {
    return {
      "note": note,
      "amount": amount.toString()
    };
  }
}