import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:xpenser_mobile/account/model/transaction.dart';

import '../model/account_summary.dart';
import 'request/account_opening_request.dart';
import 'request/deposit_money_request.dart';
import 'request/transfer_money_request.dart';
import 'request/withdraw_money_request.dart';
import 'response/account_opening_response.dart';

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

  Future<List<AccountSummary>> fetchAccountsExcluding(String accountId) async {
    var accounts = await fetchAccounts();
    return accounts.where((a) => a.id != accountId).toList();
  }

  Future<AccountSummary> fetchAccountDetails(String accountId) async {
    var response = await client.get(Uri.parse('$apiUrl/accounts/$accountId'));
    if (response.statusCode == 200) {
      return AccountSummary.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load account data');
    }
  }

  Future<AccountOpeningResponse> openAccount(AccountOpeningRequest request) async {
    var response = await client.post(Uri.parse('$apiUrl/accounts/open'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(request.toJson()));

    if (response.statusCode == 200) {
      return AccountOpeningResponse.fromJson(jsonDecode(response.body));
    }

    throw Exception("Failed to open a new account. ${response.body}");
  }

  Future<List<Transaction>> fetchAccountTransactions(String accountId) async {
    var response = await client.get(Uri.parse('$apiUrl/accounts/$accountId/transactions'));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body) as List<dynamic>;
      return body.map((data) {
        return Transaction.fromJson(data as Map<String, dynamic>);
      }).toList();
    } else {
      throw Exception('Failed to load account transactions ${response.body}');
    }
  }

  Future<bool> depositMoneyIntoAccount(String accountId, DepositMoneyRequest request) async {
    var response = await client.post(Uri.parse('$apiUrl/accounts/$accountId/transactions/deposit'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(request.toJson()));

    if (response.statusCode == 200) {
      return true;
    }

    throw Exception("Failed to deposit money into account. ${response.body}");
  }

  Future<bool> withdrawMoneyFromAccount(String accountId, WithdrawMoneyRequest request) async {
    var response = await client.post(Uri.parse('$apiUrl/accounts/$accountId/transactions/withdraw'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(request.toJson()));

    if (response.statusCode == 200) {
      return true;
    }

    throw Exception("Failed to withdraw money from account. ${response.body}");
  }

  Future<bool> transferMoneyToAnotherAccount(String accountId, TransferMoneyRequest request) async {
    var response = await client.post(Uri.parse('$apiUrl/accounts/$accountId/transactions/transfer'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(request.toJson()));

    if (response.statusCode == 200) {
      return true;
    }

    throw Exception("Failed to transfer money from account. ${response.body}");
  }
}