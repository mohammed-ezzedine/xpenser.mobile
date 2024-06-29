import 'package:flutter/material.dart';
import 'package:xpenser_mobile/account/service/account_service.dart';
import 'package:xpenser_mobile/account/service/request/deposit_money_request.dart';
import 'package:xpenser_mobile/utils/date_picker.dart';

class DepositMoneyPage extends StatefulWidget {
  const DepositMoneyPage({super.key, required this.accountId});

  final String accountId;

  @override
  State<DepositMoneyPage> createState() => _DepositMoneyPageState();
}

class _DepositMoneyPageState extends State<DepositMoneyPage> {

  final amountController = TextEditingController();
  final descriptionController = TextEditingController();
  DateTime transactionDate = DateTime.now();
  Future<bool>? response;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: (response == null) ? ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text("Deposit Money Into Account",
                style: Theme.of(context).primaryTextTheme.headlineSmall
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                controller: amountController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Enter an amount to deposit',
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
                  hintText: 'Enter a description for the deposit',
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: DatePicker(
                onChanged: (date) {
                  transactionDate = date;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilledButton(
                  child: const Text("Submit"),
                  onPressed: () {
                    setState(() {
                      var request = DepositMoneyRequest(
                        note: descriptionController.text,
                        amount: double.parse(amountController.text),
                        timestamp: transactionDate
                      );
                      response = AccountService.init().depositMoneyIntoAccount(widget.accountId, request);
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
              return const Text("Failed to submit deposit.");
            } else if (snapshot.hasData) {
              return const Text("Deposit successfully made.");
            }

            return const CircularProgressIndicator();
          }),
        ),
      ),
    );
  }
}
