import 'package:ecurie_app/Notifier/DbManagement.dart';
import 'package:ecurie_app/Notifier/SessionProvider.dart';
import 'package:ecurie_app/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<SessionProvider>(create: (context) => SessionProvider()),
      ChangeNotifierProvider<AppState>(create: (context) => AppState()),
    ],
    child: MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner : false,
    );
  }
}