import 'package:decimal/decimal.dart';

import './currency.dart';

class Budget {
  final String currencyCode;
  final double amount;

  const Budget({required this.currencyCode, required this.amount});

  factory Budget.fromJson(Map<String, dynamic> json) {
    return switch(json) {
      {
      'currencyCode': String currencyCode,
      'amount': dynamic amount,
      } => Budget(amount: double.parse(amount.toString()), currencyCode: currencyCode),
      _ => throw const FormatException('Failed to load budget')
    };
  }
}