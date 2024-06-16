
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/account_summary.dart';

class AccountDetailsSection extends StatelessWidget {
  const AccountDetailsSection({
    super.key,
    required this.accountSummary,
  });

  final AccountSummary accountSummary;

  @override
  Widget build(BuildContext context) {

    final formatCurrency = NumberFormat.currency(
      name: '',
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          accountSummary.name,
          style: Theme.of(context).primaryTextTheme.headlineSmall
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 5),
              child: Text(
                formatCurrency.format(accountSummary.budget.amount),
                style: Theme.of(context).primaryTextTheme.headlineSmall
              ),
            ),
            Text(accountSummary.budget.currencyCode)
          ],
        )
      ],
    );
  }
}
