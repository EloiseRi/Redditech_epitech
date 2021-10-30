import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';

class VideoType extends StatefulWidget {
  final Submission post;
  const VideoType({Key? key, required this.post}) : super(key: key);

  @override
  _VideoTypeState createState() => _VideoTypeState();
}

class _VideoTypeState extends State<VideoType> {
  Submission get _post => widget.post;
  VideoPlayerController? _player;
  ChewieController? _chewie;

  @override
  void initState() {
    super.initState();
    _player = VideoPlayerController.network(_post.url.toString());
    _player!.initialize();
    _chewie = ChewieController(
        videoPlayerController: _player!,
        aspectRatio: _player!.value.aspectRatio,
        allowedScreenSleep: false,
        errorBuilder: (context, error) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(
                    Icons.error,
                  ),
                  Text(
                    error,
                  )
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: _chewie!,
    );
  }

  @override
  void dispose() {
    _player?.dispose();
    _chewie?.dispose();
    super.dispose();
  }
}
