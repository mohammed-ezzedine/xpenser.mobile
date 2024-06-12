
import 'package:flutter/widgets.dart';
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
          style: const TextStyle(fontSize: 20),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 5),
              child: Text(
                formatCurrency.format(accountSummary.budget.amount),
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Text(accountSummary.budget.currencyCode)
          ],
        )
      ],
    );
  }
}
