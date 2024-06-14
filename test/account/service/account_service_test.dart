
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:xpenser_mobile/account/service/account_service.dart';
import 'package:xpenser_mobile/account/service/request/account_opening_request.dart';
import 'package:xpenser_mobile/account/service/request/deposit_money_request.dart';
import 'package:xpenser_mobile/account/service/request/transfer_money_request.dart';
import 'package:xpenser_mobile/account/service/request/withdraw_money_request.dart';

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

  group('fetch account summaries excluding a specific account', () {
    test('returns an empty list when the http call returns an empty list', () async {
      final client = MockClient();
      var accountsJson = '[]';
      when(client.get(Uri.parse('http://apiUrl/accounts')))
          .thenAnswer((_) => Future.value(http.Response(accountsJson, 200)));

      var accounts = await AccountService(client).fetchAccountsExcluding("id");
      expect(0, accounts.length);
    });

    test('returns an empty list when the http call returns a singleton list with the id matching the passed argument', () async {
      final client = MockClient();
      var accountsJson = '''[{ 
        "id": "id", 
        "name": "accountName", 
        "budget": { 
          "amount": 12.3, 
          "currencyCode": "currencyCode"
        } 
      }]''';
      when(client.get(Uri.parse('http://apiUrl/accounts')))
          .thenAnswer((_) => Future.value(http.Response(accountsJson, 200)));

      var accounts = await AccountService(client).fetchAccountsExcluding("id");
      expect(0, accounts.length);
    });

    test('returns the list of accounts when the http call returns accounts that do not match the passed id', () async {
      final client = MockClient();
      var accountsJson = '''[{ 
        "id": "id1", 
        "name": "accountName1", 
        "budget": { 
          "amount": 1, 
          "currencyCode": "currencyCode1"
        } 
      },
      { 
        "id": "id2", 
        "name": "accountName2", 
        "budget": { 
          "amount": 2, 
          "currencyCode": "currencyCode2"
        } 
      }]''';
      when(client.get(Uri.parse('http://apiUrl/accounts')))
          .thenAnswer((_) => Future.value(http.Response(accountsJson, 200)));

      var accounts = await AccountService(client).fetchAccountsExcluding("id1");
      expect(1, accounts.length);
      expect("id2", accounts.first.id);
      expect("accountName2", accounts.first.name);
      expect("currencyCode2", accounts.first.budget.currencyCode);
      expect(2, accounts.first.budget.amount);
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

  group('open a new account', () {
    test('returns the id of the newly created account when the http call completes successfully', () async {
      final client = MockClient();
      var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      };

      var request = { 
          "name": "account-name", 
          "currency": "USD", 
          "initialAmount": 123.0
        };

      var response = '''{
        "id": "account-id"
      }''';
      when(client.post(Uri.parse('http://apiUrl/accounts/open'),
        headers: headers,
        body: jsonEncode(request)
      )).thenAnswer((_) => Future.value(http.Response(response, 200)));

      var openAccount = await AccountService(client).openAccount(const AccountOpeningRequest(name: "account-name", currency: "USD", initialAmount: 123.0));
      expect(openAccount.id, "account-id");
    });
  });

  group('deposit money into account', () {
    test('returns true when the http call completes successfully', () async {
      final client = MockClient();

      var requestJson = {
        "note": "some-note",
        "amount": "10.0"
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

  group('withdraw money from account', () {
    test('returns true when the http call completes successfully', () async {
      final client = MockClient();

      var requestJson = {
        "note": "some-note",
        "amount": "10.0"
      };

      var headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };

      when(client.post(Uri.parse('http://apiUrl/accounts/123/transactions/withdraw'),
          headers: headers,
          body: jsonEncode(requestJson)
      )).thenAnswer((_) => Future.value(http.Response('', 200)));

      const request = WithdrawMoneyRequest(note: "some-note", amount: 10);
      bool response = await AccountService(client).withdrawMoneyFromAccount("123", request);

      expect(response, true);
    });
  });

  group('transfer money from account to another', () {
    test('returns true when the http call completes successfully', () async {
      final client = MockClient();

      var requestJson = {
        "destinationAccountId": "some-id",
        "amount": 10.0
      };

      var headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };

      when(client.post(Uri.parse('http://apiUrl/accounts/123/transactions/transfer'),
          headers: headers,
          body: jsonEncode(requestJson)
      )).thenAnswer((_) => Future.value(http.Response('', 200)));

      const request = TransferMoneyRequest(destinationAccountId: "some-id", amount: 10);
      bool response = await AccountService(client).transferMoneyToAnotherAccount("123", request);

      expect(response, true);
    });
  });
}