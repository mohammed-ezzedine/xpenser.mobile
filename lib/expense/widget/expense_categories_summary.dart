import 'package:flutter/material.dart';
import 'package:xpenser_mobile/expense/model/expense_category.dart';
import 'package:xpenser_mobile/expense/service/expense_category_service.dart';
import 'package:xpenser_mobile/expense/widget/expense_category_icon.dart';

import '../page/add_expense_category.dart';

class ExpenseCategoriesSummary extends StatefulWidget {
  const ExpenseCategoriesSummary({super.key});

  @override
  State<ExpenseCategoriesSummary> createState() => ExpenseCategoriesSummaryState();
}

class ExpenseCategoriesSummaryState extends State<ExpenseCategoriesSummary> {

  List<ExpenseCategory> categories = [];

  @override
  void initState() {
    super.initState();
    ExpenseCategoryService.init().fetchAll().then((values) => {
      setState(() {
        categories = values;
      })
    });
  }

  void refreshData() {
    ExpenseCategoryService.init().fetchAll().then((values) => {
      setState(() {
        categories = values;
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
              "Categories",
              style: Theme.of(context).primaryTextTheme.headlineSmall
          ),
        ),
        SizedBox(
          height: 30,
          child:  ListView(
            padding: const EdgeInsets.only(left: 20, right: 20),
            scrollDirection: Axis.horizontal,
            children: getCategoriesIcons(context),
          ),
        )
      ],
    );
  }

  List<Widget> getCategoriesIcons(BuildContext context) {
    List<Widget> list = [];
    list.add(IconButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddExpenseCategoryPage()));
        },
        icon: const Icon(Icons.add),
        color: Theme.of(context).hintColor,
    ));
    list.addAll(categories.map((c) => ExpenseCategoryIcon(category: c)));

    return list;
  }
}
