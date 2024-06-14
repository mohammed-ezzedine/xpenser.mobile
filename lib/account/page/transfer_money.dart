import 'package:flutter/material.dart';
import 'package:xpenser_mobile/account/service/request/transfer_money_request.dart';
import 'package:xpenser_mobile/account/widget/account_selector.dart';

import '../service/account_service.dart';

class TransferMoneyPage extends StatefulWidget {
  const TransferMoneyPage({super.key, required this.accountId});

  final String accountId;

  @override
  State<TransferMoneyPage> createState() => _TransferMoneyPageState();
}

class _TransferMoneyPageState extends State<TransferMoneyPage> {

  final amountController = TextEditingController();
  String? destinationAccountId;
  Future<bool>? response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
      padding: const EdgeInsets.all(20),
        child: (response == null) ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text("Transfer Money Into Account",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: AccountSelectorWidget(
              excludedAccountId: widget.accountId,
              onChanged: (accountId) {
                destinationAccountId = accountId;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
              controller: amountController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'Enter an amount to transfer',
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FilledButton(
                child: const Text("Submit"),
                onPressed: () {
                  setState(() {
                    var request = TransferMoneyRequest(destinationAccountId: destinationAccountId!, amount: double.parse(amountController.text));
                    response = AccountService.init().transferMoneyToAnotherAccount(widget.accountId, request);
                  });
                },
              ),
              TextButton(
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),

        ],
      )
          : Center (
        child: FutureBuilder(future: response, builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Failed to submit transfer.");
          } else if (snapshot.hasData) {
            return const Text("Transfer successfully made.");
          }

          return const CircularProgressIndicator();
        }),
      ),
      )
    );
  }
}
