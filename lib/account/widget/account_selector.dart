import 'package:flutter/material.dart';
import 'package:xpenser_mobile/account/model/account_summary.dart';
import 'package:xpenser_mobile/account/service/account_service.dart';

class AccountSelectorWidget extends StatefulWidget {
  const AccountSelectorWidget({super.key, required this.excludedAccountId, required this.onChanged});

  final String excludedAccountId;
  final Function(String?) onChanged;

  @override
  State<AccountSelectorWidget> createState() => _AccountSelectorWidgetState();
}

class _AccountSelectorWidgetState extends State<AccountSelectorWidget> {

  late Future<List<AccountSummary>> accounts;
  String? selectedAccount;

  @override
  void initState() {
    super.initState();
    accounts = AccountService.init().fetchAccountsExcluding(widget.excludedAccountId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: accounts,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return DropdownButton(
            hint: const Text("Pick the destination account"),
            isExpanded: true, items: snapshot.data!.map<DropdownMenuItem<String>>((account) {
              return DropdownMenuItem(
                  value: account.id,
                  child: Text(account.name)
              );
            }).toList(),
            value: selectedAccount,
            onChanged: (account) {
              setState(() {
                selectedAccount = account;
                widget.onChanged(account);
              });
            },
            elevation: 16,
            // style: TextStyle(color: Theme.of(context).focusColor),
            underline: Container(
              height: 1,
              color: Theme.of(context).dividerColor,
            ),
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.data?.toString()?? "Error");
        } else {
          return const CircularProgressIndicator();
        }
      });
  }
}
