import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_redditech/states/global_state.dart';

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
        title: const Text("USER CONNECTED"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
                onPressed: () async {
                  await Provider.of<GlobalState>(context, listen: false)
                      .logout();
                  Navigator.pushReplacementNamed(context, '/');
                },
                child: const Text('LOG OUT'),
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
