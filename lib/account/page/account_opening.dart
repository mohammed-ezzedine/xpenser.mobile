import 'package:flutter/material.dart';
import 'package:xpenser_mobile/account/page/account_details.dart';
import 'package:xpenser_mobile/account/service/account_service.dart';
import 'package:xpenser_mobile/account/service/request/account_opening_request.dart';
import 'package:xpenser_mobile/account/service/response/account_opening_response.dart';
import 'package:xpenser_mobile/currency/widget/currency_selector.dart';

class AccountOpeningPage extends StatefulWidget {
  const AccountOpeningPage({super.key});

  @override
  State<AccountOpeningPage> createState() => _AccountOpeningPageState();
}

class _AccountOpeningPageState extends State<AccountOpeningPage> {

  final nameController = TextEditingController();
  final amountController = TextEditingController();
  String? selectedCurrency;
  Future<AccountOpeningResponse>? response;
  bool isLoading = false;
  String? error = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: isLoading
          ? const CircularProgressIndicator()
          : (error != null)
          ? Text("Failed to open the account. $error")
          : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text("Create New Account",
                  style: Theme.of(context).primaryTextTheme.headlineSmall
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Enter name of the account',
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CurrencySelector(
                  onChanged: (currency) {
                    selectedCurrency = currency;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: amountController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Enter an initial amount in the account',
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FilledButton(
                    onPressed: handleAccountOpening,
                    child: const Text("Submit"),
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
      )
    );
  }

  void handleAccountOpening() {
    setState(() {
      isLoading = true;
    });

    AccountService.init().openAccount(AccountOpeningRequest(
        name: nameController.text,
        currency: selectedCurrency!,
        initialAmount: amountController.text.isNotEmpty ? double.parse(amountController.text) : 0
    )).then((response) {
      setState(() {
        isLoading = false;
      });

      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AccountDetailsPage(accountId: response.id)),
      );
    }).onError((response, stacktrace) {
      setState(() {
        isLoading = false;
        error = response.toString();
      });
    });
  }
}
