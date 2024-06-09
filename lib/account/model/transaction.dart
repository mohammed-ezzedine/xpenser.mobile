class Transaction {
  final double amount;
  final double balance;
  final String note;
  final DateTime timestamp;

  const Transaction({
    required this.amount,
    required this.balance,
    required this.note,
    required this.timestamp
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'amount': dynamic amount,
        'balance': dynamic balance,
        'note': String note,
        'timestamp': dynamic timestamp
      } => Transaction(
        amount: double.parse(amount.toString()),
        balance: double.parse(balance.toString()),
        note: note,
        timestamp: DateTime.fromMillisecondsSinceEpoch(timestamp)
      ),
      _ => throw const FormatException("Invalid transaction format.")
    };
  }
}