import 'package:flutter/material.dart';
import 'package:xpenser_mobile/account/page/account_opening.dart';

class NewAccountWidget extends StatelessWidget {
  const NewAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: .7,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AccountOpeningPage()),
          );
        },
        child: Card(
          elevation: 4,
          child: Container(
            width: 200,
            padding: const EdgeInsets.all(20),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "New Account",
                  style: TextStyle(fontSize: 16),
                ),
                Icon(Icons.add)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
