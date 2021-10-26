import 'package:draw/draw.dart';
import 'package:my_redditech/utils/secrets.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

class RedditClient {
  final Reddit reddit;

  RedditClient({required this.reddit});

  late String _username;

  String get authUrl =>
      reddit.auth.url(['*'], userAgent, compactLogin: true).toString();
  String get username => _username;

  // Usage of factory makes it possible not to create a new instance for each call.
  // The call to this function is expensive, so it's preferable to recreate the
  // instant only when necessary.
  // For more info, see : https://stackoverflow.com/a/56107639
  factory RedditClient.createInstalledFlow() {
    final Reddit reddit = Reddit.createInstalledFlowInstance(
      clientId: clientId,
      userAgent: userAgent,
      redirectUri: Uri.parse('reditech://home'),
    );

    return RedditClient(reddit: reddit);
  }

  Future<void> authorizeClient() async {
    final result = await FlutterWebAuth.authenticate(
      url: authUrl.toString(),
      callbackUrlScheme: 'reditech',
      preferEphemeral: true,
    );

    String authCode = Uri.parse(result).queryParameters["code"].toString();
    await reddit.auth.authorize(authCode);
  }

  Future<void> setUsername() async {
    Redditor redditor = await reddit.user.me() as Redditor;
    _username = redditor.displayName;
  }
}
