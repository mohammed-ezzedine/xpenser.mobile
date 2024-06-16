import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xpenser_mobile/account/model/account_summary.dart';

import '../page/account_details.dart';


class AccountSummaryWidget extends StatelessWidget {
  const AccountSummaryWidget({super.key, required this.accountSummary});

  final AccountSummary accountSummary;

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.currency(
      name: '',
    );

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AccountDetailsPage(accountId: accountSummary.id)),
        );
      },
      child: Card(
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
                  style: Theme.of(context).primaryTextTheme.titleMedium
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: Text(
                      formatNumber(formatCurrency),
                      style: Theme.of(context).primaryTextTheme.headlineSmall
                    ),
                  ),
                  Text(
                      accountSummary.budget.currencyCode
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  String formatNumber(NumberFormat formatCurrency) {
    var amount = accountSummary.budget.amount;
    String suffix = "";
    if (amount > 1000000) {
      amount = amount / 1000000;
      suffix = "M";
    }
    else if (amount > 1000) {
      amount = amount / 1000.0;
      suffix = "K";
    }

    return formatCurrency.format(amount) + suffix;
  }
}



