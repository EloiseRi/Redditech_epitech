import 'package:draw/draw.dart';
import 'package:flutter/material.dart';

class TitlePost extends StatelessWidget {
  const TitlePost({Key? key, required this.post}) : super(key: key);
  final Submission post;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white60,
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(post.data!['subreddit_name_prefixed'] +
                " · Publié par u/" +
                post.data!['author'] +
                " · Il y a " +
                (DateTime.now().difference(post.createdUtc))
                    .inHours
                    .toString() +
                "heures."),
          ]),
    );
  }
}
