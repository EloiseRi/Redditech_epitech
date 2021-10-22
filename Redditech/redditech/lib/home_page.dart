import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "REDDITECH",
              style: TextStyle(
                color: Color.fromARGB(255, 243, 69, 1),
                fontWeight: FontWeight.w700,
                fontSize: 40,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(25.0),
            ),
            const Icon(
              FontAwesomeIcons.reddit,
              color: Color.fromARGB(255, 243, 69, 1),
              size: 110,
            ),
            const Padding(
              padding: EdgeInsets.all(25.0),
            ),
            TextButton(
                onPressed: _launchReddit,
                child: const Text('LOGIN'),
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 23),
                  minimumSize: const Size(110, 45),
                  primary: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 243, 69, 1),
                )),
          ],
        ),
      ),
    );
  }
}
