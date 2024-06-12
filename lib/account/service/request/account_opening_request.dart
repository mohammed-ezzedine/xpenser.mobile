class AccountOpeningRequest {
  final String name;
  final String currency;
  final double initialAmount;

  const AccountOpeningRequest({
    required this.name,
    required this.currency,
    required this.initialAmount
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "currency": currency,
      "initialAmount": initialAmount
    };
  }
}