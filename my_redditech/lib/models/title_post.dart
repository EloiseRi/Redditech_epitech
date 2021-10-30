import 'package:draw/draw.dart';
import 'package:flutter/material.dart';

class TitlePost extends StatelessWidget {
  const TitlePost({Key? key, required this.post}) : super(key: key);
  final Submission post;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        // boxShadow: ,
        // shape: BoxShape.rectangle,
        color: Colors.white60,
        // border: Border(
        //     bottom: BorderSide(
        //         color: Colors.black38, width: 1, style: BorderStyle.solid),
        //     top: BorderSide(
        //         color: Colors.black38, width: 1, style: BorderStyle.solid)),
        // gradient:,/
      ),
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
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
    );
  }
}
