import 'package:flutter/material.dart';
import 'package:xpenser_mobile/account/page/deposit_money.dart';
import 'package:xpenser_mobile/account/page/transfer_money.dart';
import 'package:xpenser_mobile/account/page/withdraw_money.dart';
import 'package:xpenser_mobile/account/service/account_service.dart';

class AccountTransactionActions extends StatefulWidget {
  const AccountTransactionActions({super.key, required this.accountId});

  final String accountId;

  @override
  State<AccountTransactionActions> createState() => _AccountTransactionActionsState();
}

class _AccountTransactionActionsState extends State<AccountTransactionActions> {

  bool disableTransfer = true;

  @override
  void initState() {
    super.initState();
    AccountService.init().fetchAccountsExcluding(widget.accountId).then((accounts) {
      setState(() {
        disableTransfer = accounts.isEmpty;
      });
    });
  }

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
        IconButton(
          icon: const Icon(Icons.arrow_downward),
          tooltip: 'Withdraw money from the account',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WithdrawMoneyPage(accountId: widget.accountId)),
            ).then((_) => setState(() {}));
          },
        ),
        IconButton(
            icon: const Icon(Icons.arrow_forward),
            tooltip: 'Transfer money to another account',
            enableFeedback: disableTransfer,
            onPressed: disableTransfer ? null :
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TransferMoneyPage(accountId: widget.accountId)),
                ).then((_) => setState(() {}));
              }
          )
      ],
    );
  }
}
