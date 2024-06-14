class TransferMoneyRequest {
  final String destinationAccountId;
  final double amount;

  const TransferMoneyRequest({
    required this.destinationAccountId,
    required this.amount
  });

  Map<String, dynamic> toJson() {
    return {
      "destinationAccountId": destinationAccountId,
      "amount": amount
    };
  }
}