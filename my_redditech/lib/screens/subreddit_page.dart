import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:my_redditech/utils/name_tabs.dart';

class SubredditPage extends StatefulWidget {
  SubredditPage({Key? key, required this.subreddit}) : super(key: key);
  Subreddit subreddit;

  @override
  State<SubredditPage> createState() => _SubredditPageState();
}

class _SubredditPageState extends State<SubredditPage> {
  @override
  Widget build(BuildContext context) {
    String? image;
    if (Uri.parse(widget.subreddit.data!['community_icon']).isAbsolute) {
      image = Uri.parse(widget.subreddit.data!['community_icon'], 0,
              widget.subreddit.data!['community_icon'].toString().indexOf('?'))
          .toString();
    } else {
      image = 'https://zupimages.net/up/21/43/6k02.png';
    }

    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: DefaultTabController(
          length: tabsSubProfil.length,
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
                            widget.subreddit.data!['public_description'] ?? '',
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
                      tabs: tabsSubProfil,
                      labelColor: Colors.black,
                    ),
                  )),
              body: TabBarView(
                children: [
                  Column(
                    children: const [
                      Padding(padding: EdgeInsets.only(top: 50)),
                      Text('Ohh No, It\'s empty'),
                    ],
                  ),
                  Column(
                    children: const [
                      Padding(padding: EdgeInsets.only(top: 50)),
                      Text('Ohh No, It\'s empty'),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: const [
                        Padding(padding: EdgeInsets.only(top: 30)),
                        Padding(padding: EdgeInsets.all(10)),
                        Divider(
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
