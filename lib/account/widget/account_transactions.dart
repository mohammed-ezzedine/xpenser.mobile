import 'package:flutter/material.dart';
import 'package:xpenser_mobile/account/service/account_service.dart';
import 'package:xpenser_mobile/account/widget/transaction.dart';

import '../model/transaction.dart';

class AccountTransactionsWidget extends StatefulWidget {
  const AccountTransactionsWidget({super.key, required this.accountId});

  final String accountId;

  @override
  State<AccountTransactionsWidget> createState() => AccountTransactionsWidgetState();
}

class AccountTransactionsWidgetState extends State<AccountTransactionsWidget> {

  late Future<List<Transaction>> transactions;

  @override
  void initState() {
    super.initState();
    transactions = AccountService.init().fetchAccountTransactions(widget.accountId);
  }

  void refreshData() {
    transactions = AccountService.init().fetchAccountTransactions(widget.accountId);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Transactions",
          style: Theme.of(context).primaryTextTheme.headlineSmall
        ),
        FutureBuilder(future: transactions, builder: (future, placeholder) {
          if (placeholder.hasData) {
            return Column(
              children: placeholder.data!.map((transaction) {
                return TransactionWidget(transaction: transaction);
              }).toList(),
            );
          } else if (placeholder.hasError) {
            return const Text('Failed to fetch the account transactions ');
          } else {
            return const CircularProgressIndicator();
          }
        }),
      ],
    );
  }
}
