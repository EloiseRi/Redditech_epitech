import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_redditech/states/global_state.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
                  backgroundColor: const Color.fromARGB(255, 243, 69, 1),
                )),
          ],
        ),
      ),
    );
  }
}
