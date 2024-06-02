import 'package:decimal/decimal.dart';

import './currency.dart';

class Budget {
  final Currency currency;
  final Decimal amount;

  Budget({required this.currency, required this.amount});

  factory Budget.fromJson(Map<String, dynamic> json) {
    return switch(json) {
      {
      'currency': dynamic currency,
      'amount': dynamic amount,
      } => Budget(amount: Decimal.parse(amount.toString()), currency: Currency.fromJson(currency)),
      _ => throw const FormatException('Failed to load budget')
    };
  }
}