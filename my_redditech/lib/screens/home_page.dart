import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_redditech/states/global_state.dart';
import 'package:my_redditech/utils/palette.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onTapItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_outlined), label: 'Chat'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Notification'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Palette.orangeReddit,
        onTap: _onTapItem,
      ),
    );
  }
}
