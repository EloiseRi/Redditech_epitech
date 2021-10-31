import 'package:draw/draw.dart';
import 'package:flutter/material.dart';

class TitlePost extends StatelessWidget {
  const TitlePost({Key? key, required this.post}) : super(key: key);
  final Submission post;

  @override
  Widget build(BuildContext context) {
    //   String? test =
    //       post.data!['children']['data']['all_awardings']['icon_url'].toString();
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
        // color: Colors.grey.shade200,
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            Row(
              children: [
                const Padding(padding: EdgeInsets.only(top: 20, bottom: 20)),
                // Image.network(test ?? 'https://zupimages.net/up/21/43/ijqr.png'),
                Text(
                  post.data!['subreddit_name_prefixed'],
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            Row(
              children: [
                // const Padding(padding: EdgeInsets.only(left: 30)),
                Text("u/" +
                    post.data!['author'] +
                    " · " +
                    post.createdUtc.hour.toString() +
                    "h"),
              ],
            )
          ],
        ),
      ),
      // ),
    );
  }
}
