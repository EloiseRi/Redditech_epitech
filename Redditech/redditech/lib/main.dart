import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:draw/draw.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final reddit = Reddit.createInstalledFlowInstance(
    clientId: 'VdlJF8fvv4lIXesUTJA4zA',
    userAgent: 'user-reditech-app',
    redirectUri: Uri.parse('reditech://success'),
  );

  void _launchReddit() async {
    final authUrl = reddit.auth
        .url(['*'], 'user-reditech-app', compactLogin: true).toString();

    final result = await FlutterWebAuth.authenticate(
      url: authUrl.toString(),
      callbackUrlScheme: 'reditech',
      preferEphemeral: true,
    );

    String authCode = Uri.parse(result).queryParameters["code"].toString();
    await reddit.auth.authorize(authCode);
    print(await reddit.user.me());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(onPressed: () => _launchReddit(), child: Text('LOGIN'))
          ],
        ),
      ),
    );
  }
}
