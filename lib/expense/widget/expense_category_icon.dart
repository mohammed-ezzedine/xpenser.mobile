import 'package:flutter/material.dart';
import 'package:xpenser_mobile/expense/model/expense_category.dart';

class ExpenseCategoryIcon extends StatelessWidget {
  const ExpenseCategoryIcon({super.key, required this.category});
  
  final ExpenseCategory category;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          
        },
        icon: Icon(category.iconData())
    );
  }
}
