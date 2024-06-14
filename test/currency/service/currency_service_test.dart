
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:xpenser_mobile/currency/service/currency_service.dart';

import 'currency_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() async {


  setUp(() async {
    await dotenv.load(fileName: 'environment/test.env');
  });

  group("fetching the list of supported currencies", () {
    test('it should return the list of currencies when the http call completes successfully', () async {
      final client = MockClient();
      var response = '["currency1", "currency2"]';

      when(client.get(Uri.parse('http://apiUrl/currencies')))
          .thenAnswer((_) => Future.value(http.Response(response, 200)));

      var currencies = await CurrencyService(client).fetchSupportedCurrencies();
      expect(currencies.length, 2);
      expect("currency1", currencies.first);
      expect("currency2", currencies.last);
    });
  });

}