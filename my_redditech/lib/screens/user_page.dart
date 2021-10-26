import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_redditech/utils/palette.dart';
import 'package:provider/provider.dart';
import 'package:my_redditech/states/global_state.dart';
import 'package:my_redditech/models/searchbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onTapItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          child: Container(),
          preferredSize: const Size(0, 0),
        ),
        title: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 35, maxWidth: 260),
            child: const SearchBar()),
        centerTitle: true,
        leading: IconButton(
          padding: const EdgeInsets.only(top: 0, left: 12, right: 0),
          onPressed: () {},
          icon: const Icon(Icons.face),
          iconSize: 30,
          color: Colors.black,
        ),
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
                  minimumSize: const Size(120, 45),
                  primary: Colors.white,
                  backgroundColor: Palette.orangeReddit,
                ))
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
