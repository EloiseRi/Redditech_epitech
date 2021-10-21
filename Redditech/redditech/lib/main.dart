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
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'Flutter Demo Home Page'),
        '/home': (context) => const HomePage(name: "Noname")
      },
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
    redirectUri: Uri.parse('reditech://home'),
  );

  Future _launchReddit() async {
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
    print('____________');
    print(reddit.auth.credentials.toJson());
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
            TextButton(
                onPressed: () async {
                  await _launchReddit();
                  Navigator.pushReplacementNamed(context, '/home');
                },
                child: const Text('LOGIN'))
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("USER CONNECTED"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () => {},
              child: const Text('Log out'),
            ),
          ],
        ),
      ),
    );
  }
}
