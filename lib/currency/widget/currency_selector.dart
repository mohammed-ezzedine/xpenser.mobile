import 'package:flutter/material.dart';
import 'package:xpenser_mobile/currency/service/currency_service.dart';

class CurrencySelector extends StatefulWidget {
  const CurrencySelector({super.key, required this.onChanged});

  final Function(String?) onChanged;

  @override
  State<CurrencySelector> createState() => _CurrencySelectorState();
}

class _CurrencySelectorState extends State<CurrencySelector> {

  late Future<List<String>> currencies;
  String? selectedCurrency;

  @override
  void initState() {
    currencies = CurrencyService.init().fetchSupportedCurrencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: currencies,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return DropdownButton(
                items: snapshot.data!.map<DropdownMenuItem<String>>((currency) {
                  return DropdownMenuItem(
                    value: currency,
                    child: Text(currency)
                  );
                }).toList(),
                value: selectedCurrency,
                onChanged: (currency) {
                 setState(() {
                   selectedCurrency = currency.toString();
                   widget.onChanged(currency?.toString());
                 });
                },
                elevation: 16,
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
