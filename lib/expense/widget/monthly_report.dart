import 'package:flutter/material.dart';
import 'package:xpenser_mobile/expense/service/expense_report_service.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../model/monthly_report.dart';

class MonthlyReportWidget extends StatefulWidget {
  const MonthlyReportWidget({super.key});

  @override
  State<MonthlyReportWidget> createState() => _MonthlyReportWidgetState();
}

class _MonthlyReportWidgetState extends State<MonthlyReportWidget> {

  late Future<MonthlyReport> report;

  @override
  void initState() {
    super.initState();

    report = ExpenseReportService.init().fetchLatestReport();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            "Monthly Expense",
            style: Theme.of(context).primaryTextTheme.headlineSmall
          ),
        ),
        Center(
          child: FutureBuilder(
            future: report,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return CircularPercentIndicator(
                  radius: 60.0,
                  lineWidth: 5.0,
                  animation: true,
                  percent: getExpensesPercentage(snapshot.data!.report),
                  center: Text(snapshot.data!.report.expenses.toString()),
                  progressColor: getColor(snapshot.data!.report),
                );
              }

              if (snapshot.hasError) {
                return Text(snapshot.error!.toString());
              }

              return const CircularProgressIndicator();
            }
          ),
        )
      ]
    );
  }

  MaterialAccentColor getColor(MonthlyExpenses report) {
    if (getExpensesPercentage(report) < 1) {
      return Colors.greenAccent;
    }

    return Colors.redAccent;
  }

  double getExpensesPercentage(MonthlyExpenses report) {
    if (report.target != null) {
      return report.expenses / report.target!;
    }

    return 1.0;
  }
}
