import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:my_redditech/screens/controller_page.dart';
import 'package:my_redditech/states/global_state.dart';
import 'package:provider/provider.dart';

class SubredditPage extends StatefulWidget {
  SubredditPage({Key? key, required this.subreddit}) : super(key: key);
  Subreddit subreddit;

  @override
  State<SubredditPage> createState() => _PageProfilState();
}

class _PageProfilState extends State<SubredditPage> {
  late Redditor redditor;
  @override
  Widget build(BuildContext context) {
    redditor = Provider.of<GlobalState>(context, listen: false).redditor;
    String? image;
    if (Uri.parse(widget.subreddit.data!['community_icon']).isAbsolute) {
      image = Uri.parse(widget.subreddit.data!['community_icon'], 0,
              widget.subreddit.data!['community_icon'].toString().indexOf('?'))
          .toString();
    } else {
      image = 'https://zupimages.net/up/21/43/6k02.png';
    }
    final description =
        (redditor.data!['subreddit']['public_description']) == null
            ? ''
            : redditor.data!['subreddit']['public_description'];
    final media = MediaQuery.of(context).size;
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: DefaultTabController(
          length: tabs.length,
          child: Builder(builder: (BuildContext context) {
            final TabController tabController =
                DefaultTabController.of(context)!;
            tabController.addListener(() {});
            return Scaffold(
              appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(400.0),
                  child: AppBar(
                    toolbarHeight: 400,
                    flexibleSpace: Padding(
                      padding: const EdgeInsets.only(top: 40, left: 0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 55,
                            child: Image.network(
                              image!,
                            ),
                            backgroundColor: Colors.grey.shade200,
                          ),
                          const Padding(padding: EdgeInsets.only(top: 20)),
                          Text(
                            'r/' + widget.subreddit.displayName,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Padding(
                              //     padding: EdgeInsets.only(
                              //         left: media.aspectRatio * 150, top: 10)),
                              Text(
                                  widget.subreddit.data!['subscribers']
                                          .toString() +
                                      ' members',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 10),
                          ),
                          Text(
                            widget.subreddit.data!['public_description'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    foregroundColor: Colors.black,
                    centerTitle: true,
                    backgroundColor: Colors.white,
                    bottom: const TabBar(
                      tabs: tabs,
                      labelColor: Colors.black,
                    ),
                  )),
              body: TabBarView(
                children: [
                  Column(
                    children: const [
                      Padding(padding: EdgeInsets.only(top: 50)),
                      Text('Wouah, c\'est vide'),
                    ],
                  ),
                  Column(
                    children: const [
                      Padding(padding: EdgeInsets.only(top: 50)),
                      Text('Wouah, c\'est vide'),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 30)),
                        const Padding(padding: EdgeInsets.all(10)),
                        const Divider(
                          color: Colors.black,
                          thickness: 1,
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
        ));
  }
}
