import 'package:flutter/material.dart';
import 'package:my_redditech/states/global_state.dart';
import 'package:provider/provider.dart';

class SubProfil extends StatelessWidget {
  const SubProfil({Key? key, required this.name, required this.color})
      : super(key: key);

  final String name;
  final Color color;
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            foregroundColor: Colors.black,
            title: Text(name),
            centerTitle: true,
            backgroundColor: color),
      );
}

class PageParameters extends StatelessWidget {
  const PageParameters({Key? key, required this.name, required this.color})
      : super(key: key);

  final String name;
  final Color color;
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.black,
          title: Text(name),
          centerTitle: true,
          backgroundColor: color),
      body: Container(
        padding: const EdgeInsets.only(top: 50, left: 15),
        child: Column(
          children: <Widget>[
            const Text(
              'Paramètres du compte',
              textAlign: TextAlign.right,
            ),
            TextButton(
                onPressed: () async {
                  await Provider.of<GlobalState>(context, listen: false)
                      .logout();
                  Navigator.pushReplacementNamed(context, '/');
                },
                child: const Text('LOG OUT'),
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 15),
                  // minimumSize: const Size(120, 45),
                  primary: Colors.white,
                  backgroundColor: Colors.grey,
                ))
          ],
        ),
      ));
}
