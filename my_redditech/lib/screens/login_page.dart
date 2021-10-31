import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_redditech/states/global_state.dart';
import 'package:my_redditech/utils/palette.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                color: Palette.orangeReddit,
                fontWeight: FontWeight.w700,
                fontSize: 40,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(25.0),
            ),
            const ImageIcon(
              AssetImage('lib/assets/reddit_icon.png'),
              color: Palette.orangeReddit,
              size: 110,
            ),
            const Padding(
              padding: EdgeInsets.all(25.0),
            ),
            TextButton(
                onPressed: () async {
                  await Provider.of<GlobalState>(context, listen: false)
                      .authorizeClient();
                  Navigator.pushReplacementNamed(context, '/home');
                },
                child: const Text('LOGIN'),
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 23),
                  minimumSize: const Size(110, 45),
                  primary: Colors.white,
                  backgroundColor: Palette.orangeReddit,
                )),
          ],
        ),
      ),
    );
  }
}
