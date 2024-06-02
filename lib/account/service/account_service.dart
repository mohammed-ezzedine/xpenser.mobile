import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../model/account_summary.dart';

class AccountService {

  final http.Client client;

  AccountService(this.client);

  Future<List<AccountSummary>> fetchAccounts() async {
    var response = await client.get(Uri.parse('${dotenv.env["API_URL"]}/accounts'));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body) as List<dynamic>;
      return body.map((data) {
        return AccountSummary.fromJson(data as Map<String, dynamic>);
      }).toList();
    } else {
      throw Exception('Failed to load accounts data');
    }
  }

}