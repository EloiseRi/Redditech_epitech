import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YtVideoType extends StatefulWidget {
  final String url;

  const YtVideoType({Key? key, required this.url}) : super(key: key);

  @override
  _YtVideoTypeState createState() => _YtVideoTypeState();
}

class _YtVideoTypeState extends State<YtVideoType> {
  String get _url => widget.url;

  late YoutubePlayerController _youtubePlayerController;

  @override
  void initState() {
    super.initState();
    String? id = RegExp(
            r"(?:youtube\.com\/\S*(?:(?:\/e(?:mbed))?\/|watch\?(?:\S*?&?v\=))|youtu\.be\/)([a-zA-Z0-9_-]{6,11})")
        .firstMatch(_url)!
        .group(1);

    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: id!,
      flags: YoutubePlayerFlags(
        enableCaption: false,
        autoPlay: false,
        controlsVisibleAtStart: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _youtubePlayerController,
      progressIndicatorColor: Colors.orange,
      progressColors: ProgressBarColors(
        playedColor: Colors.orange,
        bufferedColor: Colors.blueGrey,
      ),
    );
  }

  @override
  void dispose() {
    _youtubePlayerController.dispose();
    super.dispose();
  }
}
