
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:xpenser_mobile/expense/model/expense_category_creation_request.dart';
import 'package:xpenser_mobile/expense/service/expense_category_service.dart';

import 'expense_category_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() async {


  setUp(() async {
    await dotenv.load(fileName: 'environment/test.env');
  });

  group("fetching the list of expense categories", () {
    test('it should return the list of categories when the http call completes successfully', () async {
      final client = MockClient();
      var response = '''[
        {
          "id": "categoryId",
          "name": "categoryName",
          "icon": "categoryIcon"
        }
      ]''';

      when(client.get(Uri.parse('http://apiUrl/expenses/categories')))
          .thenAnswer((_) => Future.value(http.Response(response, 200)));

      var currencies = await ExpenseCategoryService(client).fetchAll();
      expect(currencies.length, 1);
      expect("categoryId", currencies.first.id);
      expect("categoryName", currencies.first.name);
      expect("categoryIcon", currencies.first.icon);
    });
  });

  group("creating a new expense category", () {
    test('it should return the created category when the http call completes successfully', () async {
      final client = MockClient();
      var response = '''
        {
          "id": "categoryId",
          "name": "categoryName",
          "icon": "categoryIcon"
        }
      ''';

      var request = {
        "name": "categoryName",
        "icon": "categoryIcon"
      };

      when(client.post(Uri.parse('http://apiUrl/expenses/categories'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(request)
      ))
          .thenAnswer((_) => Future.value(http.Response(response, 200)));

      var currencies = await ExpenseCategoryService(client).create(ExpenseCategoryCreationRequest(name: "categoryName", icon: "categoryIcon"));
      expect("categoryId", currencies.id);
      expect("categoryName", currencies.name);
      expect("categoryIcon", currencies.icon);
    });
  });

}