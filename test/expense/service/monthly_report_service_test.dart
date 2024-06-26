import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:xpenser_mobile/expense/service/expense_report_service.dart';

import 'expense_category_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() async {

    setUp(() async {
        await dotenv.load(fileName: 'environment/test.env');
    });

    group("when fetching the latest monthly expenses report", () {

        test("it should return the report when the http call completes successfully", () async {
            final client = MockClient();
            var response = '''{
              "first": "2024-01",
              "last": "2024-06",
              "report": {
                "month": "2024-03",
                "incoming": 1234,
                "expenses": 567,
                "target": 1000
              }
            }''';

            when(client.get(Uri.parse('http://apiUrl/expenses/reports/latest')))
                .thenAnswer((_) => Future.value(http.Response(response, 200)));

            var report = await ExpenseReportService(client).fetchLatestReport();
            expect("2024-01", report.first);
            expect("2024-06", report.last);
            expect("2024-03", report.report.month);
            expect(1234.0, report.report.incoming);
            expect(567.0, report.report.expenses);
            expect(1000.0, report.report.target);
        });

        test("it should treat the monthly target as an optional field", () async {
            final client = MockClient();
            var response = '''{
              "first": "2024-01",
              "last": "2024-06",
              "report": {
                "month": "2024-03",
                "incoming": 1234,
                "expenses": 567,
                "target": null
              }
            }''';

            when(client.get(Uri.parse('http://apiUrl/expenses/reports/latest')))
                .thenAnswer((_) => Future.value(http.Response(response, 200)));

            var report = await ExpenseReportService(client).fetchLatestReport();
            expect("2024-01", report.first);
            expect("2024-06", report.last);
            expect("2024-03", report.report.month);
            expect(1234.0, report.report.incoming);
            expect(567.0, report.report.expenses);
            expect(null, report.report.target);
        });
    });

    group("when fetching the monthly expenses report for a specific month", () {

        test("it should return the report when the http call completes successfully", () async {
            final client = MockClient();
            var response = '''{
              "first": "2024-01",
              "last": "2024-06",
              "report": {
                "month": "2024-03",
                "incoming": 1234,
                "expenses": 567,
                "target": 1000
              }
            }''';

            when(client.get(Uri.parse('http://apiUrl/expenses/reports?month=2024-03')))
                .thenAnswer((_) => Future.value(http.Response(response, 200)));

            var report = await ExpenseReportService(client).fetchReport("2024-03");
            expect("2024-01", report.first);
            expect("2024-06", report.last);
            expect("2024-03", report.report.month);
            expect(1234.0, report.report.incoming);
            expect(567.0, report.report.expenses);
            expect(1000.0, report.report.target);
        });

        test("it should treat the monthly target as an optional field", () async {
            final client = MockClient();
            var response = '''{
              "first": "2024-01",
              "last": "2024-06",
              "report": {
                "month": "2024-03",
                "incoming": 1234,
                "expenses": 567,
                "target": null
              }
            }''';

            when(client.get(Uri.parse('http://apiUrl/expenses/reports?month=2024-03')))
                .thenAnswer((_) => Future.value(http.Response(response, 200)));

            var report = await ExpenseReportService(client).fetchReport("2024-03");
            expect("2024-01", report.first);
            expect("2024-06", report.last);
            expect("2024-03", report.report.month);
            expect(1234.0, report.report.incoming);
            expect(567.0, report.report.expenses);
            expect(null, report.report.target);
        });
    });
}
