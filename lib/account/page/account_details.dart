import 'package:flutter/material.dart';
import 'package:xpenser_mobile/account/model/account_summary.dart';
import 'package:xpenser_mobile/account/service/account_service.dart';
import 'package:xpenser_mobile/account/widget/account_transactions.dart';

import '../widget/account_details_section.dart';
import '../widget/account_transaction_actions.dart';

class AccountDetailsPage extends StatefulWidget {
  const AccountDetailsPage({super.key, required this.accountId});

  final String accountId;

  @override
  State<AccountDetailsPage> createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {

  late Future<AccountSummary> accountSummary;

  @override
  void initState() {
    super.initState();
    accountSummary = AccountService.init().fetchAccountDetails(widget.accountId);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Account Details"),
      ),
      body: FutureBuilder(future: accountSummary, builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            padding: const EdgeInsets.all(20),
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: AccountDetailsSection(accountSummary: snapshot.data!),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: AccountTransactionActions(accountId: snapshot.data!.id),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: AccountTransactionsWidget(accountId: snapshot.data!.id),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("Failed to fetch the account details."),
          );
        }

        return const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
