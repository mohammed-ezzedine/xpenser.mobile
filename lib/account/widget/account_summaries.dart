
import 'package:flutter/material.dart';
import 'package:xpenser_mobile/account/widget/account_summary.dart';
import 'package:xpenser_mobile/account/widget/new_account.dart';

import '../model/account_summary.dart';
import '../service/account_service.dart';

class AccountSummariesWidget extends StatefulWidget {
  const AccountSummariesWidget({super.key});

  @override
  State<AccountSummariesWidget> createState() => AccountSummariesWidgetState();
}

class AccountSummariesWidgetState extends State<AccountSummariesWidget> {

  late Future<List<AccountSummary>> accountSummaries;

  @override
  void initState() {
    super.initState();
    accountSummaries = AccountService.init().fetchAccounts();
  }

  void refreshData() {
    setState(() {
      accountSummaries = AccountService.init().fetchAccounts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: accountSummaries, builder: (context, placeholder) {
      if (placeholder.hasData) {
        return SizedBox(
          height: 150,
          child: ListView(
            padding: const EdgeInsets.only(left: 20, right: 20),
            scrollDirection: Axis.horizontal,
            children: getAccountsWidgets(placeholder.data!),
          ),
        );
      } else if (placeholder.hasError) {
        return Text("Error: ${placeholder.error!}");
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }

  List<Widget> getAccountsWidgets(List<AccountSummary> accounts) {
    Iterable<Widget> widgets = accounts.map((a) => AccountSummaryWidget(accountSummary: a));
    return widgets.followedBy([const NewAccountWidget()]).toList();
  }
}
