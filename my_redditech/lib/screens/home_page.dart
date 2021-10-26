import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:my_redditech/screens/profil_page.dart';
import 'package:my_redditech/utils/palette.dart';

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
      drawer: const NavigationDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          child: Container(),
          preferredSize: const Size(0, 8),
        ),
        title: Container(
          padding:
              const EdgeInsets.only(top: 12, bottom: 12, left: 12, right: 50),
          child: Column(
            children: const <Widget>[
              SizedBox(
                height: 16.0,
              ),
              TextField(
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    prefixIconConstraints: BoxConstraints(
                      minHeight: 16.0,
                      minWidth: 38.0,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    fillColor: Color.fromARGB(40, 20, 20, 20),
                    filled: true,
                    isDense: true,
                    hintText: 'Search ...',
                    hintStyle: TextStyle(color: Colors.black),
                    contentPadding: EdgeInsets.all(8.0),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    )),
              ),
            ],
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) => IconButton(
            padding: const EdgeInsets.only(top: 15, left: 20),
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(Icons.face),
            iconSize: 30,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // children: <Widget>[
          //   TextButton(
          //       onPressed: () async {
          //         await Provider.of<GlobalState>(context, listen: false)
          //             .logout();
          //         Navigator.pushReplacementNamed(context, '/');
          //       },
          //       child: const Text('LOG OUT'),
          //       style: TextButton.styleFrom(
          //         textStyle: const TextStyle(fontSize: 23),
          //         minimumSize: const Size(120, 45),
          //         primary: Colors.white,
          //         backgroundColor: Palette.orangeReddit,
          //       ))
          // ],
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
