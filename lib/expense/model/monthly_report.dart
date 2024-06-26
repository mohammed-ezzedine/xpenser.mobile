import 'dart:convert';

class MonthlyReport {
  final String first;
  final String last;
  final MonthlyExpenses report;

  const MonthlyReport({
    required this.first,
    required this.last,
    required this.report
  });

  factory MonthlyReport.fromJson(Map<String, dynamic> json) {
    return switch(json) {
      {
        "first": String first,
        "last": String last,
        "report": dynamic report
      } => MonthlyReport(first: first, last: last, report: MonthlyExpenses.fromJson(report as Map<String, dynamic>)),
      _ => throw Exception("Failed to parse Monthly Report")
    };
  }
}

class MonthlyExpenses {
  final String month;
  final double incoming;
  final double expenses;
  final double? target;

  const MonthlyExpenses({
    required this.month,
    required this.incoming,
    required this.expenses,
    this.target
  });

  factory MonthlyExpenses.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "month": String month,
        "incoming": dynamic incoming,
        "expenses": dynamic expenses,
        "target": dynamic target
      } => MonthlyExpenses(
          month: month,
          incoming: double.parse(incoming.toString()),
          expenses: double.parse(expenses.toString()),
          target: target == null ? null : double.parse(target.toString())
      ),
      _ => throw Exception("Failed to parse Monthly Expenses")
    };
  }
}