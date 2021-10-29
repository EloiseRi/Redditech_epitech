import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:my_redditech/models/title_post.dart';
import 'package:my_redditech/states/posts_state.dart';
import 'package:provider/provider.dart';

const List<Tab> tabs = <Tab>[
  Tab(text: 'Publications'),
  Tab(text: 'Commentaires'),
  Tab(text: 'À propos'),
];

class PostsPage extends StatefulWidget {
  const PostsPage({Key? key, required this.startingIndex}) : super(key: key);
  final int startingIndex;
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  late PageController _controller;
  bool shouldPop = true;
  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<PostsState>(
          builder: (context, state, _) {
            return WillPopScope(
              onWillPop: () async {
                return shouldPop;
              },
              child: StreamBuilder(
                stream: state.controller.stream,
                builder: (context, snapshot) => PageView.builder(
                    pageSnapping: false,
                    controller: _controller,
                    scrollDirection: Axis.vertical,
                    itemCount: state.contentList.length,
                    itemBuilder: (context, index) {
                      Submission post = state.contentList[index];
                      bool loadMore = (index > state.contentList.length - 10);
                      return SingleChildScrollView(
                        child: Center(
                          child: TitlePost(
                            post: post, 
                          ),
                        ),
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
