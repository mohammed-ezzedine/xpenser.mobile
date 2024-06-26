import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:xpenser_mobile/account/widget/account_summaries.dart';
import 'package:xpenser_mobile/expense/widget/expense_categories_summary.dart';

import 'expense/widget/monthly_report.dart';

void main() async {
  const envFileName = "environment/${const String.fromEnvironment('profile')}.env";
  await dotenv.load(fileName: envFileName);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xpenser',
      theme: ThemeData.from(
        colorScheme: ColorScheme.dark(
          background: Colors.black,
       )
      ),
      home: const MyHomePage(title: 'Xpenser'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<AccountSummariesWidgetState> _accountSummariesKey = GlobalKey<AccountSummariesWidgetState>();
  final GlobalKey<ExpenseCategoriesSummaryState> _expenseCategorySummariesKey = GlobalKey<ExpenseCategoriesSummaryState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _accountSummariesKey.currentState?.refreshData();
          _expenseCategorySummariesKey.currentState?.refreshData();
        },
        child: Container(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              AccountSummariesWidget(key: _accountSummariesKey),
              ExpenseCategoriesSummary(key: _expenseCategorySummariesKey),
              MonthlyReportWidget()
            ],
          ),
        ),
      ),
    );
  }
}