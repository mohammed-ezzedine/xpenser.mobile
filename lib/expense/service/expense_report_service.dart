import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../model/monthly_report.dart';

class ExpenseReportService {
  final http.Client client;
  String apiUrl = '';

  ExpenseReportService(this.client) {
    apiUrl = dotenv.env["API_URL"]?? "";
  }

  factory ExpenseReportService.init() {
    return ExpenseReportService(http.Client());
  }

  Future<MonthlyReport> fetchLatestReport() async {
    var response = await client.get(Uri.parse("$apiUrl/expenses/reports/latest"));
    if (response.statusCode != 200) {
      throw Exception("Failed to fetch the monthly report");
    }

    return MonthlyReport.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  Future<MonthlyReport> fetchReport(String month) async {
    var response = await client.get(Uri.parse("$apiUrl/expenses/reports?month=$month"));
    if (response.statusCode != 200) {
      throw Exception("Failed to fetch the monthly report");
    }

    return MonthlyReport.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

}