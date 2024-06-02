import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xpenser_mobile/account/model/account_summary.dart';
import 'package:intl/intl.dart';


class AccountSummaryWidget extends StatelessWidget {
  const AccountSummaryWidget({super.key, required this.accountSummary});

  final AccountSummary accountSummary;

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.currency(
      name: '',
    );

    return Card(
      elevation: 4,
      child: Container(
        // width: double.infinity,
        // height: 80,
        width: 200,
        padding: const EdgeInsets.all(20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                accountSummary.name,
                style: const TextStyle(fontSize: 16),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: Text(
                      formatCurrency.format(accountSummary.budget.amount),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  Text(
                    accountSummary.budget.currency.code
                  )
                ],
              )
            ],
          ),
        ),
    );
  }
}



