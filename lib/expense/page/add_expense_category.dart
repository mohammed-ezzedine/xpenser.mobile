import 'package:flutter/material.dart';
import 'package:xpenser_mobile/expense/model/expense_category.dart';
import 'package:xpenser_mobile/expense/model/expense_category_creation_request.dart';
import 'package:xpenser_mobile/expense/service/expense_category_service.dart';
import 'package:xpenser_mobile/utils/icon_picker.dart';

class AddExpenseCategoryPage extends StatefulWidget {
  const AddExpenseCategoryPage({super.key});

  @override
  State<AddExpenseCategoryPage> createState() => _AddExpenseCategoryPageState();
}

class _AddExpenseCategoryPageState extends State<AddExpenseCategoryPage> {

  final nameController = TextEditingController();
  String? categoryIcon;

  Future<ExpenseCategory>? response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body:  Container(
        padding: const EdgeInsets.all(20),
        child: (response == null)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text("New Expense Category",
                      style: Theme.of(context).primaryTextTheme.headlineSmall
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'Enter the name of the category',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: IconPicker(
                      onChanged: (icon) {
                        categoryIcon = icon;
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
                            var request = ExpenseCategoryCreationRequest(
                              name: nameController.text,
                              icon: categoryIcon!
                            );
                            response = ExpenseCategoryService.init().create(request);
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
                    return Text(snapshot.error.toString());
                  } else if (snapshot.hasData) {
                    return const Text("Expense category is created.");
                  }

                  return const CircularProgressIndicator();
                }
              ),
            ),
      )
    );
  }
}
