import 'package:flutter/cupertino.dart';
import 'package:draw/draw.dart';
import 'package:uuid/uuid.dart';
import 'package:my_redditech/utils/secrets.dart';
import 'package:my_redditech/service/reddit_client.dart';

class GlobalState with ChangeNotifier {
  String get authUrl => _redditClient.authUrl;
  String get username => _redditClient.username;

  late RedditClient _redditClient;

  Future<void> initApp() async {
    // print("Initilization of the Reddit client...");
    _redditClient = RedditClient.createInstalledFlow();
  }

  Future<void> authorizeClient() async {
    await _redditClient.authorizeClient();
    await _redditClient.setUsername();
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
