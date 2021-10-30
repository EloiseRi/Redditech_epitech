import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_redditech/screens/controller_page.dart';
import 'package:my_redditech/states/posts_state.dart';
import 'package:my_redditech/widgets/gfycattype.dart';
import 'package:my_redditech/widgets/imagetype.dart';
import 'package:my_redditech/widgets/selftype.dart';
import 'package:my_redditech/widgets/videotype.dart';
import 'package:my_redditech/widgets/yttype.dart';
import 'package:provider/provider.dart';

class DisplayPost extends StatefulWidget {
  final Submission post;
  final bool loadMore;

  const DisplayPost({
    Key? key,
    required this.post,
    required this.loadMore,
  }) : super(key: key);

  @override
  _DisplayPost createState() => _DisplayPost();
}

class _DisplayPost extends State<DisplayPost> {
  Submission? _post;
  bool get _loadMore => widget.loadMore;
  String? _type;

  @override
  void initState() {
    super.initState();
    _post = widget.post;
    _type = getType();
    if (_loadMore) {
      Provider.of<PostsState>(context, listen: false)
          .fetchPosts(loadMore: true);
    }
  }

  String getType() {
    if (_post!.isSelf) return 'selfType';
    if (_post!.isVideo) return 'videoType';
    if (RegExp(r"\.(jpe?g|png|bmp|gif)$").hasMatch(_post!.url.toString()))
      return 'imageType';
    if (RegExp(
            r"(?:youtube\.com\/\S*(?:(?:\/e(?:mbed))?\/|watch\?(?:\S*?&?v\=))|youtu\.be\/)([a-zA-Z0-9_-]{6,11})")
        .hasMatch(_post!.url.toString())) return 'ytType';
    if (_post!.url.toString().contains('.gifv')) return 'videoGType';
    if (_post!.domain == "gfycat.com") return 'gfycatType';
    if (_post!.domain == "imgur.com") return 'imgurType';
    return 'linkType';
  }

  void refreshPost() async {
    dynamic post = await _post!.refresh();
    setState(() {
      _post = post.first;
    });
  }

  void vote(VoteState vote) async {
    if (vote != _post!.vote) {
      if (vote == VoteState.upvoted) {
        await _post!.upvote();
      } else if (vote == VoteState.downvoted) {
        await _post!.downvote();
      }
    } else {
      await _post!.clearVote();
    }
    refreshPost();
  }

  @override
  Widget build(BuildContext context) {
    String? url = _post?.thumbnail.toString();
    Widget widget = Image.network(url != 'self' && url != 'default' && url != ''
        ? url!
        : 'https://zupimages.net/up/21/43/ijqr.png');
    switch (_type) {
      case 'selfType':
        widget = SelfType(content: _post!.selftext!);
        break;
      case 'videoType':
        widget = VideoType(post: _post!);
        break;
      case 'videoGType':
        widget = VideoType(post: _post!);
        break;
      case 'imageType':
        widget = ImageType(
          url: _post!.url.toString(),
        );
        break;
      case 'gfycatType':
        widget = GfycatVideoType(url: _post!.url);
        break;
      case 'imgurType':
        String id = _post!.url.path.substring(1);
        widget = ImageType(
          url: "https://i.imgur.com/$id.jpg",
        );
        break;
      case 'ytbType':
        widget = YtVideoType(url: _post!.url.toString());
        break;
      case 'linkType':
        break;
      default:
        widget = Image.network(_post!.thumbnail.toString());
    }
    return Column(
      children: [
        Text(_post!.title),
        widget,
        Container(
            child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () => vote(VoteState.upvoted),
              child: Icon(
                Icons.arrow_upward,
                color: _post!.vote == VoteState.upvoted
                    ? Colors.orange
                    : Colors.grey.shade700,
              ),
            ),
            Text(_post!.score.toString()),
            GestureDetector(
                onTap: () => vote(VoteState.downvoted),
                child: Icon(
                  Icons.arrow_downward,
                  color: _post!.vote == VoteState.downvoted
                      ? Colors.orange
                      : Colors.grey.shade700,
                )),
            const SizedBox(
              width: 15,
            ),
            const Icon(
              Icons.comment,
              color: Colors.grey,
            ),
            Text(_post!.numComments.toString()),
          ],
        ))
      ],
    );
  }
}
