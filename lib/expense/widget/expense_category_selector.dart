import 'package:flutter/material.dart';
import 'package:xpenser_mobile/expense/service/expense_category_service.dart';

import '../model/expense_category.dart';

class ExpenseCategorySelector extends StatefulWidget {
  const ExpenseCategorySelector({super.key, required this.onChanged});

  final Function(String?) onChanged;

  @override
  State<ExpenseCategorySelector> createState() => _ExpenseCategorySelectorState();
}

class _ExpenseCategorySelectorState extends State<ExpenseCategorySelector> {

  late Future<List<ExpenseCategory>> categories;
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    categories = ExpenseCategoryService.init().fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: categories,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return DropdownButton(
              items: snapshot.data!.map<DropdownMenuItem<String>>((category) {
                return DropdownMenuItem(
                    value: category.id,
                    child: Text(category.name)
                );
              }).toList(),
              value: selectedCategory,
              onChanged: (category) {
                setState(() {
                  selectedCategory = category.toString();
                  widget.onChanged(category?.toString());
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
