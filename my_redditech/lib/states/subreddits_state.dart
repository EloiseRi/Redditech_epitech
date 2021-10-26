import 'package:flutter/cupertino.dart';
import 'package:draw/draw.dart';
import 'package:my_redditech/service/reddit_client.dart';

class SubredditsState with ChangeNotifier {
  final RedditClient redditClient;

  SubredditsState({required this.redditClient});

  Future<List<String>> searchSubreddit(String query) async {
    List<SubredditRef> subs =
        await redditClient.reddit.subreddits.searchByName(query);
    List<String> subsNames = subs
        .map((sub) => (sub.path).substring(0, (sub.path).length - 1))
        .toList();

    return subsNames;
  }

  Future<void> getUserSub() async {
    List<Multireddit>? multireddits =
        await redditClient.reddit.user.multireddits();
    if (multireddits != null) {
      for (Multireddit multi in multireddits) {
        String subreddit = multi.subreddits.map((s) => s.displayName).join('+');
        print(subreddit);
      }
    }
  }

  @override
  void notifyListeners();
}
