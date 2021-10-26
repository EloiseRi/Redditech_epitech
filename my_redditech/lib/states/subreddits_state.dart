import 'package:flutter/cupertino.dart';
import 'package:draw/draw.dart';
import 'package:my_redditech/service/reddit_client.dart';

class SubredditsState with ChangeNotifier {
  final RedditClient redditClient;

  SubredditsState({required this.redditClient});

  Future<List<String>> searchSubreddit(String query) async {
    List<SubredditRef> subs =
        await redditClient.reddit.subreddits.searchByName(query);
    List<String> subsNames = subs.map((sub) => sub.displayName).toList();
    print(subsNames);
    return subsNames;
  }

  @override
  void notifyListeners();
}
