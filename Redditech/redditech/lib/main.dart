import 'package:flutter/material.dart';
// import 'package:flutter_web_auth/flutter_web_auth.dart';
// import 'package:draw/draw.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'home_page.dart';

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
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey.shade200,
      ),
      home: const MyHomePage(title: 'reditech'),
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => const MyHomePage(title: 'reditech'),
      //   // '/home': (context) => const
      // }
    );
  }
}
