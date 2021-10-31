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
      setBusy(value: false);
      notifyListeners();
    });
  }

  late StreamController<UserContent> controller;
  List<Submission> contentList = [];
  bool _isLoading = false;
  String currentSource = 'new';

  List<Submission> get contents => List.from(contentList);
  bool get isLoading => _isLoading;

  void fetchPosts({
    String? source,
    int maxLoaded = 50,
    bool loadMore = false,
  }) {
    setBusy();
    source = source ?? currentSource;
    if (!loadMore) contentList.clear();
    setSource(source);
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
      case "new":
        stream = redditClient.reddit.front.newest(
          limit: maxLoaded,
          after: next,
        );
        break;
      case "hot":
        stream = redditClient.reddit.front.hot(
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

  void setBusy({bool value = true}) {
    _isLoading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }
}
