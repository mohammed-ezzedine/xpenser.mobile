import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class CurrencyService {

  http.Client client;
  String apiUrl = '';

  CurrencyService(this.client) {
    apiUrl = dotenv.env["API_URL"] ?? '';
  }

  factory CurrencyService.init() {
    return CurrencyService(http.Client());
  }

  Future<List<String>> fetchSupportedCurrencies() async {
    var response = await client.get(Uri.parse("$apiUrl/currencies"));
    if (response.statusCode == 200) {
      var responseList = jsonDecode(response.body) as List<dynamic>;
      return responseList.map((c) => c.toString()).toList();
    }

    throw Exception("Failed to fetch the list of supported currencies.");
  }
}