import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:my_redditech/models/display_post.dart';
import 'package:my_redditech/models/title_post.dart';
import 'package:my_redditech/states/posts_state.dart';
import 'package:provider/provider.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({Key? key, required this.startingIndex, required this.source})
      : super(key: key);
  final int startingIndex;
  final String source;

  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  late PageController _controller;
  bool shouldPop = true;
  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Consumer<PostsState>(
          builder: (context, state, _) {
            return WillPopScope(
              onWillPop: () async {
                Provider.of<PostsState>(context, listen: false)
                    .fetchPosts(source: 'new');
                return shouldPop;
              },
              child: StreamBuilder(
                stream: state.controller.stream,
                builder: (context, snapshot) => ListView.builder(
                    controller: _controller,
                    scrollDirection: Axis.vertical,
                    itemCount: state.contentList.length,
                    itemBuilder: (context, index) {
                      Submission post = state.contentList[index];
                      bool loadMore = (index > state.contentList.length - 10);
                      return SingleChildScrollView(
                        child: Column(children: [
                          Card(
                              margin: const EdgeInsets.only(
                                  top: 10, left: 5, right: 5, bottom: 0),
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Padding(
                                          padding: EdgeInsets.only(left: 25)),
                                      TitlePost(
                                        post: post,
                                      ),
                                    ],
                                  ),
                                  DisplayPost(
                                    post: post,
                                    loadMore: loadMore,
                                  ),
                                ],
                              ))
                        ]),
                      );
                    }),
              ),
            );
          },
        ),
      ),
    );
  }
}
