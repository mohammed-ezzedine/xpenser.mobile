import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:xpenser_mobile/expense/model/expense_category_creation_request.dart';

import '../model/expense_category.dart';

class ExpenseCategoryService {

  final http.Client client;
  String apiUrl = '';

  ExpenseCategoryService(this.client) {
    apiUrl = dotenv.env["API_URL"]?? "";
  }

  factory ExpenseCategoryService.init() {
    return ExpenseCategoryService(http.Client());
  }

  Future<List<ExpenseCategory>> fetchAll() async {
    var response = await client.get(Uri.parse("$apiUrl/expenses/categories"));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body) as List<dynamic>;
      return body
          .map((e) => e as Map<String, dynamic>)
          .map(ExpenseCategory.fromJson).toList();
    }

    throw Exception("Failed to fetch the list of expense categories");
  }

  Future<ExpenseCategory> create(ExpenseCategoryCreationRequest request) async {
    var response = await client.post(Uri.parse("$apiUrl/expenses/categories"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(request.toJson())
    );

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body) as Map<String, dynamic>;
      return ExpenseCategory.fromJson(body);
    }

    throw Exception("Failed to create a new expense category ${response.body}");
  }
}