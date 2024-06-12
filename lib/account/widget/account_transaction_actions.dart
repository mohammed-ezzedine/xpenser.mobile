import 'package:flutter/material.dart';
import 'package:xpenser_mobile/account/page/deposit_money.dart';

class AccountTransactionActions extends StatefulWidget {
  const AccountTransactionActions({super.key, required this.accountId});

  final String accountId;

  @override
  State<AccountTransactionActions> createState() => _AccountTransactionActionsState();
}

class _AccountTransactionActionsState extends State<AccountTransactionActions> {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_upward),
          tooltip: 'Deposit money into the account',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DepositMoneyPage(accountId: widget.accountId)),
            ).then((_) => setState(() {}));
          },
        ),
      ],
    );
  }
}
