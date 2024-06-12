import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:xpenser_mobile/account/widget/account_summaries.dart';

void main() async {
  const envFileName = "environment/${const String.fromEnvironment('profile')}.env";
  await dotenv.load(fileName: envFileName);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xpenser',
      theme: ThemeData(
        colorScheme: ColorScheme.dark(
          background: Colors.black,
          surface: Colors.white10
        ),
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Xpenser'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: const Column(
          children: [
            AccountSummariesWidget(),
          ],
        ),
      ),
    );
  }
}