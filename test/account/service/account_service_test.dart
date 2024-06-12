
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:xpenser_mobile/account/service/account_service.dart';

import 'account_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() async {

  setUp(() async {
    await dotenv.load(fileName: 'environment/test.env');
  });

  group('fetch account summaries', () {
    test('returns a list of account summaries if the http call completes successfully', () async {
      final client = MockClient();
      var accountsJson = '''[{ 
        "id": "accountId", 
        "name": "accountName", 
        "budget": { 
          "amount": 12.3, 
          "currencyCode": "currencyCode"
        } 
      }]''';
      when(client.get(Uri.parse('http://apiUrl/accounts')))
          .thenAnswer((_) => Future.value(http.Response(accountsJson, 200)));

      var accounts = await AccountService(client).fetchAccounts();
      expect(1, accounts.length);
      expect("accountId", accounts.first.id);
      expect("accountName", accounts.first.name);
      expect("currencyCode", accounts.first.budget.currencyCode);
      expect(12.3, accounts.first.budget.amount);
    });
  });

  group('fetch account summary', () {
    test('returns the account summary if the http call completes successfully', () async {
      final client = MockClient();
      var accountsJson = '''{ 
        "id": "accountId", 
        "name": "accountName", 
        "budget": { 
          "amount": 12.3, 
          "currencyCode": "currencyCode"
        } 
      }''';
      when(client.get(Uri.parse('http://apiUrl/accounts/123')))
          .thenAnswer((_) => Future.value(http.Response(accountsJson, 200)));

      var accounts = await AccountService(client).fetchAccountDetails("123");
      expect("accountId", accounts.id);
      expect("accountName", accounts.name);
      expect("currencyCode", accounts.budget.currencyCode);
      expect(12.3, accounts.budget.amount);
    });
  });

  group('fetch account transactions', () {
    test('returns a list of transactions when the http call completes successfully', () async {
      final client = MockClient();
      var accountsJson = '''[{ 
        "amount": 10, 
        "balance": 93.2, 
        "note": "some-note",
        "timestamp": 1717321158742
      }]''';
      when(client.get(Uri.parse('http://apiUrl/accounts/123/transactions')))
          .thenAnswer((_) => Future.value(http.Response(accountsJson, 200)));

      var transactions = await AccountService(client).fetchAccountTransactions("123");
      expect(transactions.length, 1);
      expect(transactions.first.amount, 10.0);
      expect(transactions.first.balance, 93.2);
      expect(transactions.first.note, "some-note");
      expect(transactions.first.timestamp, DateTime.fromMillisecondsSinceEpoch(1717321158742));
    });
  });

  group('deposit money into account', () {
    test('returns true when the http call completes successfully', () async {
      final client = MockClient();

      var requestJson = {
        "note": "some-note",
        "amount": 10.0
      };

      var headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };

      when(client.post(Uri.parse('http://apiUrl/accounts/123/transactions/deposit'),
          headers: headers,
          body: jsonEncode(requestJson)
      )).thenAnswer((_) => Future.value(http.Response('', 200)));

      const request = DepositMoneyRequest(note: "some-note", amount: 10);
      bool response = await AccountService(client).depositMoneyIntoAccount("123", request);

      expect(response, true);
    });
  });
}