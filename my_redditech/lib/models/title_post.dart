import 'package:draw/draw.dart';
import 'package:flutter/material.dart';

class TitlePost extends StatelessWidget {
  const TitlePost({Key? key, required this.post}) : super(key: key);
  final Submission post;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.grey.shade200,
      ),
      child: Card(
        // shadowColor: Colors.green,
        margin: const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 0),
        color: Colors.white,
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 15),
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                Row(
                  children: [
                    Text(
                      post.data!['subreddit_name_prefixed'],
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("u/" +
                        post.data!['author'] +
                        " · " +
                        (DateTime.now().difference(post.createdUtc))
                            .inHours
                            .toString() +
                        "h"),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
