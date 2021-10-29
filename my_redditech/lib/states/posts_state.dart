import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:draw/draw.dart';
import 'package:my_redditech/service/reddit_client.dart';

class PostsState with ChangeNotifier {
  final RedditClient redditClient;

  PostsState({required this.redditClient}) {
    controller = StreamController.broadcast();

    controller.stream.listen((event) {
      Submission content = event as Submission;
      content.refreshComments();
      contentList.add(content);
    }, onDone: () {
      notifyListeners();
    });
  }

  late StreamController<UserContent> controller;
  List<Submission> contentList = [];
  String? currentSource;

  List<Submission> get contents => List.from(contentList);

  void fetchPosts({
    String? source,
    int maxLoaded = 30,
    bool loadMore = false,
  }) {
    source = source ?? currentSource;
    if (!loadMore) contentList.clear();

    setSource(source!);
    notifyListeners();

    String? next = loadMore ? contentList.last.fullname : null;
    Stream<UserContent> stream;
    switch (source) {
      case "front page":
        stream = redditClient.reddit.front.best(
          limit: maxLoaded,
          after: next,
        );
        break;
      default:
        stream = redditClient.reddit.subreddit(source).hot(
              limit: maxLoaded,
              after: next,
            );
        break;
    }
    controller.addStream(stream);
  }

  void setSource(String source) {
    currentSource = source;
    notifyListeners();
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }
}
