import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_redditech/models/display_post.dart';
import 'package:my_redditech/models/title_post.dart';
import 'package:my_redditech/screens/posts_page.dart';
import 'package:my_redditech/states/posts_state.dart';
import 'package:my_redditech/utils/name_tabs.dart';
import 'package:provider/provider.dart';

class SubRedditPage extends StatefulWidget {
  SubRedditPage({Key? key, required this.subreddit}) : super(key: key);
  Subreddit subreddit;

  @override
  State<SubRedditPage> createState() => _SubRedditPageState();
}

class _SubRedditPageState extends State<SubRedditPage> {
  late PageController _controller;
  bool shouldPop = true;
  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

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

    String? banner;
    if (Uri.parse(widget.subreddit.data?['banner_background_image'])
        .isAbsolute) {
      banner = Uri.parse(
              widget.subreddit.data?['banner_background_image'],
              0,
              widget.subreddit.data?['banner_background_image']
                  .toString()
                  .indexOf('?'))
          .toString();
    } else {
      banner =
          'https://styles.redditmedia.com/t5_2r0ij/styles/bannerBackgroundImage_6gx1wewyz5x11.jpg';
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: DefaultTabController(
        length: tabsSubreddit.length,
        child: Builder(
          builder: (BuildContext context) {
            final TabController tabController =
                DefaultTabController.of(context)!;
            tabController.addListener(() {});
            return Scaffold(
              body: Stack(
                children: <Widget>[
                  TabBarView(
                    children: [
                      Column(
                        children: <Widget>[
                          Expanded(
                              child: PostsPage(
                                  startingIndex: 0,
                                  source: widget.subreddit.displayName))
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: [
                            const Padding(padding: EdgeInsets.only(top: 30)),
                            const Padding(padding: EdgeInsets.all(10)),
                            Expanded(
                              child: Text(
                                widget.subreddit.data!['public_description'] ??
                                    '',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(300.0),
                child: AppBar(
                  toolbarHeight: 100,
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          banner!,
                        ),
                        fit: BoxFit.contain,
                        alignment: Alignment.topLeft,
                      ),
                    ),
                    child: Column(
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 100)),
                        Row(
                          children: [
                            const Padding(padding: EdgeInsets.only(left: 10)),
                            CircleAvatar(
                              radius: 30,
                              child: Image.network(
                                image!,
                              ),
                              backgroundColor: Colors.grey.shade200,
                            ),
                            const Padding(padding: EdgeInsets.only(top: 20)),
                            Text(
                              '  r/' + widget.subreddit.displayName,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Padding(padding: EdgeInsets.only(left: 10)),
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
                        Container(
                          constraints: const BoxConstraints(
                            minHeight: 50,
                            minWidth: 50,
                            maxHeight: 50,
                            maxWidth: 400,
                          ),
                          child: Text(
                            widget.subreddit.data!['public_description'] ?? '',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.only(top: 40, left: 0),
                  //   child: Column(
                  //     children: [
                  //       CircleAvatar(
                  //         radius: 55,
                  //         child: Image.network(
                  //           image!,
                  //         ),
                  //         backgroundColor: Colors.grey.shade200,
                  //       ),
                  //       const Padding(padding: EdgeInsets.only(top: 20)),
                  //       Text(
                  //         'r/' + widget.subreddit.displayName,
                  //         style: const TextStyle(
                  //           fontSize: 20,
                  //         ),
                  //       ),
                  //       Row(
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         children: [
                  //           Text(
                  //               widget.subreddit.data!['subscribers']
                  //                       .toString() +
                  //                   ' members',
                  //               textAlign: TextAlign.center,
                  //               style: const TextStyle(fontSize: 12)),
                  //         ],
                  //       ),
                  //       const Padding(
                  //         padding: EdgeInsets.only(top: 10),
                  //       ),
                  //       Container(
                  //         constraints: const BoxConstraints(
                  //           minHeight: 50,
                  //           minWidth: 50,
                  //           maxHeight: 50,
                  //           maxWidth: 400,
                  //         ),
                  //         child: Text(
                  //           widget.subreddit.data!['public_description'] ?? '',
                  //           textAlign: TextAlign.center,
                  //           style: const TextStyle(
                  //             fontSize: 12,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // // foregroundColor: Colors.black,
                  centerTitle: true,
                  backgroundColor: Colors.white,
                  bottom: const TabBar(
                    tabs: tabsSubreddit,
                    labelColor: Colors.black,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
