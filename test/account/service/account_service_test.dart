
import 'dart:io';

import 'package:decimal/decimal.dart';
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
          "currency": { 
            "code": "currencyCode", 
            "name": "currencyName", 
            "symbol": "currencySymbol" 
          }
        } 
      }]''';
      when(client.get(Uri.parse('http://apiUrl/accounts')))
          .thenAnswer((_) => Future.value(http.Response(accountsJson, 200)));

      var accounts = await AccountService(client).fetchAccounts();
      expect(1, accounts.length);
      expect("accountId", accounts.first.id);
      expect("accountName", accounts.first.name);
      expect("currencyCode", accounts.first.budget.currency.code);
      expect("currencyName", accounts.first.budget.currency.name);
      expect("currencySymbol", accounts.first.budget.currency.symbol);
      expect(Decimal.fromJson("12.3"), accounts.first.budget.amount);
    });
  });
}