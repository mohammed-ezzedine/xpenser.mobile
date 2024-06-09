import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:xpenser_mobile/account/model/account_summary.dart';
import 'package:xpenser_mobile/account/widget/account_transactions.dart';

class AccountDetailsPage extends StatefulWidget {
  const AccountDetailsPage({super.key, required this.accountSummary});

  final AccountSummary accountSummary;

  @override
  State<AccountDetailsPage> createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.currency(
      name: '',
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Account Details"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.accountSummary.name,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 5),
                        child: Text(
                          formatCurrency.format(widget.accountSummary.budget.amount),
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Text(widget.accountSummary.budget.currencyCode)
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Transactions",
                    style: TextStyle(fontSize: 20),
                  ),
                  AccountTransactionsWidget(accountId: widget.accountSummary.id),
                ],
              ),
            ),
          ],
        ),
      ),
    );;
  }
}
