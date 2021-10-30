import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_redditech/screens/controller_page.dart';
import 'package:my_redditech/states/posts_state.dart';
import 'package:my_redditech/widgets/imagetype.dart';
import 'package:my_redditech/widgets/selftype.dart';
import 'package:my_redditech/widgets/videotype.dart';
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
    if (_loadMore)
      Provider.of<PostsState>(context, listen: false)
          .fetchPosts(loadMore: true);
  }

  String getType() {
    if (_post!.isSelf) return 'selfType';
    if (_post!.isVideo) return 'videoType';
    if (RegExp(r"\.(jpe?g|png|bmp|gif)$").hasMatch(_post!.url.toString()))
      return 'imageType';
    if (_post!.url.toString().contains('.gifv')) return 'videoGType';
    if (_post!.domain == "gfycat.com") return 'gfycatType';
    if (_post!.domain == "imgur.com") return 'imgurType';
    return 'linkType';
  }

  @override
  Widget build(BuildContext context) {
    Widget? widget;
    switch (_type) {
      case 'selfType':
        widget = SelfType(content: _post!.selftext!);
        break;
      case 'videoType':
        widget = VideoType(post: _post!);
        break;
      case 'videoGType':
        break;
      case 'imageType':
        widget = ImageType(
          url: _post!.url.toString(),
        );
        break;
      case 'gfycatType':
        break;
      case 'imgurType':
        break;
      case 'linkType':
        break;
      default:
        throw "Unknown type";
    }
    return Column(
      children: [
        widget!,
      ],
    );
  }
}
