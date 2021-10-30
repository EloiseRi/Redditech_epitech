import 'dart:ui';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:my_redditech/screens/profil_page.dart';
import 'package:my_redditech/screens/controller_page.dart';
import 'package:my_redditech/states/global_state.dart';
import 'package:my_redditech/utils/name_tabs.dart';
import 'package:my_redditech/utils/palette.dart';
import 'package:my_redditech/models/searchbar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late Redditor redditor;

  void _onTapItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    redditor = Provider.of<GlobalState>(context, listen: false).redditor;
    return SizedBox(
        width: 5,
        height: 5,
        child: DefaultTabController(
          length: tabsHomePage.length,
          child: Builder(builder: (BuildContext context) {
            final TabController tabController =
                DefaultTabController.of(context)!;
            tabController.addListener(() {});
            return Scaffold(
              drawer: NavigationDrawer(),
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(110.0),
                child: AppBar(
                  toolbarHeight: 110,
                  backgroundColor: Colors.white,
                  bottom: const TabBar(
                    tabs: tabsHomePage,
                    labelColor: Colors.black,
                  ),
                  title: ConstrainedBox(
                      constraints:
                          const BoxConstraints(maxHeight: 35, maxWidth: 260),
                      child: const SearchBar()),
                  centerTitle: true,
                  leading: Builder(
                    builder: (BuildContext context) => IconButton(
                      padding:
                          const EdgeInsets.only(top: 0, left: 12, right: 0),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      icon: CircleAvatar(
                        child: Image.network(
                          redditor.data!['snoovatar_img'].toString(),
                        ),
                        backgroundColor: Colors.grey.shade200,
                      ),
                      iconSize: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              body: TabBarView(
                children: [
                  Column(
                    children: const <Widget>[
                      Expanded(
                        // flex: 1,
                        child: PostsPage(
                            // child: Column(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            startingIndex: 0,
                            source: 'hot'),
                      ),
                    ],
                  ),
                  Column(
                    children: const <Widget>[
                      Expanded(
                        // flex: 1,
                        child: PostsPage(
                            // child: Column(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            startingIndex: 0,
                            source: "front page"),
                      ),
                    ],
                  ),
                  Column(
                    children: const <Widget>[
                      Expanded(
                        // flex: 1,
                        child: PostsPage(
                            // child: Column(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            startingIndex: 0,
                            source: "new"),
                      ),
                    ],
                  ),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                unselectedItemColor: Colors.grey,
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.search), label: 'Search'),
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
          }),
        ));
  }
}
