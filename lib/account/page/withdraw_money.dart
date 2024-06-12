import 'package:flutter/material.dart';
import 'package:xpenser_mobile/account/service/account_service.dart';
import 'package:xpenser_mobile/account/service/request/deposit_money_request.dart';
import 'package:xpenser_mobile/account/service/request/withdraw_money_request.dart';

class WithdrawMoneyPage extends StatefulWidget {
  const WithdrawMoneyPage({super.key, required this.accountId});

  final String accountId;

  @override
  State<WithdrawMoneyPage> createState() => _WithdrawMoneyPageState();
}

class _WithdrawMoneyPageState extends State<WithdrawMoneyPage> {

  final amountController = TextEditingController();
  final descriptionController = TextEditingController();
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
              child: Text("Withdraw Money From Account",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                controller: amountController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Enter an amount to withdraw',
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Enter a description for the withdrawal',
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilledButton(
                  child: const Text("Submit"),
                  onPressed: () {
                    setState(() {
                      response = AccountService.init().withdrawMoneyFromAccount(widget.accountId, WithdrawMoneyRequest(note: descriptionController.text, amount: double.parse(amountController.text)));
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
              return const Text("Failed to submit withdrawal.");
            } else if (snapshot.hasData) {
              return const Text("Withdrawal successfully made.");
            }

            return const CircularProgressIndicator();
          }),
        ),
      ),
    );
  }
}
