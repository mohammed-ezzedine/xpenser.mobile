import './budget.dart';

class AccountSummary {
  final String id;
  final String name;
  final Budget budget;

  const AccountSummary({
    required this.id,
    required this.name,
    required this.budget
  });

  factory AccountSummary.fromJson(Map<String, dynamic> json) {
    return switch(json) {
      {
        'id': String id,
        'name': String name,
        'budget': dynamic budget
      } => AccountSummary(id: id, name: name, budget: Budget.fromJson(budget)),
      _ => throw const FormatException('Failed to load account')
    };
  }
}
