import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:xpenser_mobile/account/model/transaction.dart';

class TransactionWidget extends StatelessWidget {
  const TransactionWidget({super.key, required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.currency(
      name: '',
    );

    return Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.note,
                    style: TextStyle(fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(DateFormat.yMMMd().format(transaction.timestamp))
                ],
              )
            ),
            Text(
              formatCurrency.format(transaction.amount),
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
    );
  }
}
