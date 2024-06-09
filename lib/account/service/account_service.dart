import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:xpenser_mobile/account/model/transaction.dart';
import '../model/account_summary.dart';

class AccountService {

  http.Client client;
  String apiUrl = '';

  AccountService(this.client) {
    apiUrl = dotenv.env["API_URL"] ?? '';
  }

  factory AccountService.init() {
    return AccountService(http.Client());
  }

  Future<List<AccountSummary>> fetchAccounts() async {
    var response = await client.get(Uri.parse('$apiUrl/accounts'));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body) as List<dynamic>;
      return body.map((data) {
        return AccountSummary.fromJson(data as Map<String, dynamic>);
      }).toList();
    } else {
      throw Exception('Failed to load accounts data');
    }
  }

  Future<List<Transaction>> fetchAccountTransactions(String accountId) async {
    var response = await client.get(Uri.parse('$apiUrl/accounts/$accountId/transactions'));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body) as List<dynamic>;
      return body.map((data) {
        return Transaction.fromJson(data as Map<String, dynamic>);
      }).toList();
    } else {
      throw Exception('Failed to load account transactions ' + response.body);
    }
  }
}