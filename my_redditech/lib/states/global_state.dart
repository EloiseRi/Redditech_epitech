import 'package:flutter/cupertino.dart';
import 'package:draw/draw.dart';
import 'package:my_redditech/states/posts_state.dart';
import 'package:uuid/uuid.dart';
import 'package:my_redditech/utils/secrets.dart';
import 'package:my_redditech/service/reddit_client.dart';
import 'package:my_redditech/states/subreddits_state.dart';

class GlobalState with ChangeNotifier {
  String get authUrl => _redditClient.authUrl;
  String get username => _redditClient.username;
  SubredditsState get subredditsState => _subredditsState;
  PostsState get postsState => _postsState;
  Redditor get redditor => _redditClient.redditor;

  late RedditClient _redditClient;
  late SubredditsState _subredditsState;
  late PostsState _postsState;
  late Redditor _redditor;

  Future<void> initApp() async {
    print("Initilization of the Reddit client...");
    _redditClient = RedditClient.createInstalledFlow();

    _subredditsState = SubredditsState(redditClient: _redditClient);
    _postsState = PostsState(redditClient: _redditClient);
  }

  Future<void> authorizeClient() async {
    await _redditClient.authorizeClient();
    await _redditClient.setUsername();
    _postsState.fetchPosts(source: "front page");
  }

  Future<void> logout() async {
    _redditClient.reddit.auth.refresh();
    Reddit reddit = await Reddit.createUntrustedReadOnlyInstance(
      clientId: clientId,
      userAgent: userAgent,
      deviceId: const Uuid().v4(),
    );
  }

  @override
  notifyListeners();
}
