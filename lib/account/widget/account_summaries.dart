
import 'package:flutter/material.dart';
import 'package:xpenser_mobile/account/widget/account_summary.dart';

import '../model/account_summary.dart';
import '../service/account_service.dart';

class AccountSummariesWidget extends StatefulWidget {
  const AccountSummariesWidget({super.key});

  @override
  State<AccountSummariesWidget> createState() => _AccountSummariesWidgetState();
}

class _AccountSummariesWidgetState extends State<AccountSummariesWidget> {

  late Future<List<AccountSummary>> accountSummaries;

  @override
  void initState() {
    super.initState();
    accountSummaries = AccountService.init().fetchAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: accountSummaries, builder: (context, placeholder) {
      if (placeholder.hasData) {
        return Container(
          height: 150,
          child: ListView(
            padding: EdgeInsets.only(left: 20, right: 20),
            scrollDirection: Axis.horizontal,
            children: placeholder.data!.map((a) {
              return AccountSummaryWidget(accountSummary: a);
            }).toList(),
          ),
        );
      } else if (placeholder.hasError) {
        return Text("Error: ${placeholder.error!}");
      } else {
        return const CircularProgressIndicator();
      }
    });
  }
}
