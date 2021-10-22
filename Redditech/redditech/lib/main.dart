import 'package:flutter/material.dart';
import 'home_page.dart';
import 'log_out.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'reditech',
      theme: ThemeData(
        primarySwatch: Colors.orange ,
        scaffoldBackgroundColor: Colors.grey.shade200,
      ),
      // home: const MyHomePage(title: 'reditech'),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'Flutter Demo Home Page'),
        '/home': (context) => const HomePage(name: "Noname")
      },
    );
  }
}